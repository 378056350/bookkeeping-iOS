/**
 * 定时
 * @author 郑业强 2018-12-18 创建文件
 */

#import "TIController.h"
#import "TITableView.h"
#import "BottomButton.h"
#import "TIModel.h"
#import "TITableCell.h"
#import "CA_EVENT.h"
#import "TIMING_EVENT.h"


#pragma mark - 声明
@interface TIController()<UNUserNotificationCenterDelegate>

@property (nonatomic, strong) TITableView *table;
@property (nonatomic, strong) BottomButton *bottom;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end

#pragma mark - 实现
@implementation TIController


#pragma mark - UNUserNotificationCenterDelegate
// iOS 10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler  API_AVAILABLE(ios(10.0)) {
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        UNNotificationRequest *request = notification.request;
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        NSNumber *badge = content.badge;  // 推送消息的角标
        NSString *body = content.body;    // 推送消息体
        UNNotificationSound *sound = content.sound;  // 推送消息的声音
        NSString *subtitle = content.subtitle;  // 推送消息的副标题
        NSString *title = (NSString *)content.title;  // 推送消息的标题
        
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            NSLog(@"iOS10 前台收到远程通知:%@", body);
            
        } else {
            // 判断为本地通知
            NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        }
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    }
}

- (void)addNotification:(NSString *)time {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"" arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        content.body  = [NSString localizedUserNotificationStringForKey:@"记账时间到了，赶紧记一笔吧！" arguments:nil];
        
        
        
        // 周一早上 8：00 上班
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.hour = [[time componentsSeparatedByString:@":"][0] integerValue];
        components.minute = [[time componentsSeparatedByString:@":"][1] integerValue];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
        
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"TestRequest" content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            NSLog(@"成功添加推送");
        }];
        
       
        
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            NSLog(@"123");
        }];
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"定时提醒"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self table];
    [self bottom];
    [self.view bringSubviewToFront:self.bottom];
    //    [self timeListRequest];


    [self setModels:[NSUserDefaults objectForKey:PIN_TIMING]];
    
}


#pragma mark - 请求
// 定时列表
- (void)timeListRequest {
    @weakify(self)
    [self createRequest:TimeListRequest params:nil complete:^(APPResult *result) {
        @strongify(self)
        [self setModels:[TIModel mj_objectArrayWithKeyValuesArray:result.data]];
    }];
}
// 添加定时
- (void)addTimeRequest:(NSString *)time {
    @weakify(self)
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:time, @"time", nil];
    [self showProgressHUD];
    [AFNManager POST:AddTimeRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        TIModel *model = [[TIModel alloc] init];
        [model setTime:time];
        [self.models addObject:model];
        [self setModels:self.models];
    }];
}
// 删除定时
- (void)deleteTimeRequest:(TITableCell *)cell {
    //    @weakify(self)
    //    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@(cell.model.Id), @"id", nil];
    //    [self showProgressHUD];
    //    [AFNManager POST:RemoveTimeRequest params:param complete:^(APPResult *result) {
    //        @strongify(self)
    //        [self hideHUD];
    //        [self.models removeObject:cell.model];
    //        [self.table deleteRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //    }];
}


// 添加定时
- (void)addTimingRequest:(NSString *)time {
    NSMutableArray *arrm = [NSUserDefaults objectForKey:PIN_TIMING];
    NSMutableArray *arrm_has_synced = [NSUserDefaults objectForKey:PIN_TIMING_HAS_SYNCED];
    NSMutableArray *arrm_remove_synced = [NSUserDefaults objectForKey:PIN_TIMING_REMOVE_SYNCED];
    // 时间已存在
    if ([arrm containsObject:time]) {
        [self showTextHUD:@"已经添加过该时间的提醒" delay:2.f];
    }
    // 时间不存在
    else {
        [arrm addObject:time];
        [arrm sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
        [NSUserDefaults setObject:arrm forKey:PIN_TIMING];
        
        
        if ([arrm_remove_synced containsObject:time]) {
            [arrm_remove_synced removeObject:time];
            [NSUserDefaults setObject:arrm_remove_synced forKey:PIN_TIMING_REMOVE_SYNCED];
        }
        else {
            [arrm_has_synced addObject:time];
            [arrm_has_synced sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                return [obj1 compare:obj2];
            }];
            [NSUserDefaults setObject:arrm_has_synced forKey:PIN_TIMING_HAS_SYNCED];
        }
        
        
        [self setModels:arrm];
        [self.table reloadData];
        
    }
}
// 删除定时
- (void)deleteTimingRequest:(NSString *)time {
    NSMutableArray *arrm = [NSUserDefaults objectForKey:PIN_TIMING];
    NSMutableArray *arrm_has_synced = [NSUserDefaults objectForKey:PIN_TIMING_HAS_SYNCED];
    NSMutableArray *arrm_remove_synced = [NSUserDefaults objectForKey:PIN_TIMING_REMOVE_SYNCED];
    
    [arrm removeObject:time];
    [NSUserDefaults setObject:arrm forKey:PIN_TIMING];
    
    if ([arrm_has_synced containsObject:time]) {
        [arrm_has_synced removeObject:time];
        [NSUserDefaults setObject:arrm_has_synced forKey:PIN_TIMING_HAS_SYNCED];
    }
    else {
        [arrm_remove_synced addObject:time];
        [NSUserDefaults setObject:arrm_remove_synced forKey:PIN_TIMING_REMOVE_SYNCED];
    }
        
    [self setModels:arrm];
    [self.table reloadData];
    
}


#pragma mark - 事件
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    [self handleEventWithName:eventName data:data];
}
- (void)handleEventWithName:(NSString *)eventName data:(id)data {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    [super routerEventWithName:eventName data:data];
}
// 添加定时
- (void)bottomClick:(id)data {
    @weakify(self)
    [BRDatePickerView showDatePickerWithTitle:@"每天" dateType:BRDatePickerModeHM defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        @strongify(self)
        [self addTimingRequest:selectValue];
        //        [self addTimeRequest:selectValue];
    }];
}
// 删除cell
- (void)timeCellDelete:(TITableCell *)cell {
    //    [self deleteTimeRequest:cell];
    [self deleteTimingRequest:cell.time];
}


#pragma mark - set
- (void)setModels:(NSMutableArray *)models {
    _models = models;
    _table.models = models;
}


#pragma mark - get
- (TITableView *)table {
    if (!_table) {
        _table = [TITableView initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - self.bottom.height)];
        [self.view addSubview:_table];
    }
    return _table;
}
- (BottomButton *)bottom {
    if (!_bottom) {
        _bottom = [BottomButton initWithFrame:({
            CGFloat height = countcoordinatesX(50) + SafeAreaBottomHeight;
            CGFloat top = SCREEN_HEIGHT - height;
            CGRectMake(0, top, SCREEN_WIDTH, height);
        })];
        [_bottom setName:@"添加提醒"];
        [self.view addSubview:_bottom];
    }
    return _bottom;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           CATEGORY_BTN_CLICK: [self createInvocationWithSelector:@selector(bottomClick:)],
                           TIMING_CELL_DELETE: [self createInvocationWithSelector:@selector(timeCellDelete:)],
                           };
    }
    return _eventStrategy;
}


@end
