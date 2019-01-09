/**
 * 首页
 * @author 郑业强 2018-12-16 创建文件
 */

#import "HomeController.h"
#import "HomeNavigation.h"
#import "HomeHeader.h"
#import "HomeList.h"
#import "HomeListSubCell.h"
#import "LoginController.h"
#import "BKModel.h"
#import "BDController.h"
#import "HOME_EVENT.h"


#pragma mark - 声明
@interface HomeController()<UNUserNotificationCenterDelegate>

@property (nonatomic, strong) HomeNavigation *navigation;
@property (nonatomic, strong) HomeHeader *header;
@property (nonatomic, strong) HomeList *list;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSMutableArray<BKMonthModel *> *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation HomeController


#pragma mark - UNUserNotificationCenterDelegate
// iOS 10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", body);
        
    } else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:@"记账时间到了，赶紧记一笔吧！" arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        
        
//        // 周一早上 8：00 上班
//        NSDateComponents *components = [[NSDateComponents alloc] init];
//        components.hour = 8;
//        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];


        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"TestRequest" content:content trigger:nil];

        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            NSLog(@"成功添加推送");
        }];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:true];
    [self navigation];
    [self header];
    [self list];
    [self setDate:[NSDate date]];
    [self monitorNotification];
    [self setModels:[BKMonthModel statisticalMonthWithYear:_date.year month:_date.month]];
}
// 监听通知
- (void)monitorNotification {
    // 记账
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOT_BOOK_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self setModels:[BKMonthModel statisticalMonthWithYear:self.date.year month:self.date.month]];
    }];
    // 删除记账
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOT_BOOK_DELETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self setModels:[BKMonthModel statisticalMonthWithYear:self.date.year month:self.date.month]];
    }];
}


#pragma mark - 请求
// 查账
- (void)bookRequest:(NSDate *)date {
//    // 未登录
//    if (![UserInfo isLogin]) {
//        BKModel *model = [BKModel new];
//        model.listSorts = @[].mutableCopy;
//        model.group = @[].mutableCopy;
//        model.list = @[].mutableCopy;
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self setModel:model];
//            [self setDate:date];
//        });
//        return;
//    }
    
//    // 已登录
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           @(date.year), @"year",
//                           @(date.month), @"month",
//                           @(1), @"hasList",
//                           @(1), @"hasGroup", nil];
//    @weakify(self)
//    [AFNManager POST:GetBookRequest params:param complete:^(APPResult *result) {
//        @strongify(self)
//        // 成功
//        if (result.status == ServiceCodeSuccess) {
//            [self setModel:[BKModel mj_objectWithKeyValues:result.data]];
//            [self setDate:date];
//        }
//        // 失败
//        else {
//            [self showWindowTextHUD:result.message delay:1.f];
//        }
//    }];
}


#pragma mark - set
- (void)setModels:(NSMutableArray<BKMonthModel *> *)models {
    _models = models;
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        self.header.models = models;
        self.list.models = models;
    });
}
- (void)setDate:(NSDate *)date {
    _date = date;
    _header.date = date;
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
// 点击月份
- (void)homeMonthClick:(id)data {
    @weakify(self)
    NSDate *date = self.date;
    NSDate *min = [NSDate br_setYear:2000 month:1 day:1];
    NSDate *max = [NSDate br_setYear:[NSDate date].year + 3 month:12 day:31];
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYM defaultSelValue:[date formatYM] minDate:min maxDate:max isAutoSelect:false themeColor:nil resultBlock:^(NSString *selectValue) {
        @strongify(self)
        [self setDate:[NSDate dateWithYM:selectValue]];
        [self setModels:[BKMonthModel statisticalMonthWithYear:self.date.year month:self.date.month]];
    }];
}
// 下拉
- (void)homeTablePull:(id)data {
    [self setDate:[self.date offsetMonths:1]];
    [self setModels:[BKMonthModel statisticalMonthWithYear:_date.year month:_date.month]];
}
// 上拉
- (void)homeTableUp:(id)data {
    [self setDate:[self.date offsetMonths:-1]];
    [self setModels:[BKMonthModel statisticalMonthWithYear:_date.year month:_date.month]];
}
// 删除Cell
- (void)homeTableCellRemove:(HomeListSubCell *)cell {
    NSLog(@"删除Cell");
    // 删除
    NSMutableArray<BKModel *> *bookArrm = [[PINCacheManager sharedManager] objectForKey:PIN_BOOK];
    NSMutableArray<BKModel *> *bookSyncedArrm = [[PINCacheManager sharedManager] objectForKey:PIN_BOOK_SYNCED];
    if ([bookSyncedArrm containsObject:cell.model]) {
        [bookSyncedArrm removeObject:cell.model];
    }
    [bookArrm removeObject:cell.model];
    [[PINCacheManager sharedManager] setObject:bookArrm forKey:PIN_BOOK];
    [[PINCacheManager sharedManager] setObject:bookArrm forKey:PIN_BOOK_SYNCED];
    
    // 更新
    [[NSNotificationCenter defaultCenter] postNotificationName:NOT_BOOK_DELETE object:nil];
}
// 点击Cell
- (void)homeTableCellClick:(BKModel *)model {
    NSNumber *detail = [[PINCacheManager sharedManager] objectForKey:PIN_SETTING_DETAIL];
    // 详情
    if ([detail boolValue] == true) {
        BDController *vc = [[BDController alloc] init];
        vc.model = model;
        vc.complete = ^{
            [self setModels:[BKMonthModel statisticalMonthWithYear:_date.year month:_date.month]];
        };
        [self.navigationController pushViewController:vc animated:true];
    }
    // 修改
    else {
        BKCController *vc = [[BKCController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:true];
    }
}


#pragma mark - get
- (HomeNavigation *)navigation {
    if (!_navigation) {
        _navigation = [HomeNavigation loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight)];
        [self.view addSubview:_navigation];
    }
    return _navigation;
}
- (HomeHeader *)header {
    if (!_header) {
        _header = [HomeHeader loadFirstNib:CGRectMake(0, _navigation.bottom, SCREEN_WIDTH, countcoordinatesX(64))];
        [self.view addSubview:_header];
    }
    return _header;
}
- (HomeList *)list {
    if (!_list) {
        _list = [HomeList loadCode:({
            CGFloat top = CGRectGetMaxY(_header.frame);
            CGFloat height = SCREEN_HEIGHT - top - TabbarHeight;
            CGRectMake(0, top, SCREEN_WIDTH, height);
        })];
        [self.view addSubview:_list];
    }
    return _list;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           HOME_MONTH_CLICK: [self createInvocationWithSelector:@selector(homeMonthClick:)],
                           HOME_TABLE_PULL: [self createInvocationWithSelector:@selector(homeTablePull:)],
                           HOME_TABLE_UP: [self createInvocationWithSelector:@selector(homeTableUp:)],
                           HOME_CELL_REMOVE: [self createInvocationWithSelector:@selector(homeTableCellRemove:)],
                           HOME_CELL_CLICK: [self createInvocationWithSelector:@selector(homeTableCellClick:)],
                           
                           };
    }
    return _eventStrategy;
}


@end
