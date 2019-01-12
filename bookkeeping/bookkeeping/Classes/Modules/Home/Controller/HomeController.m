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
#import "ACAListModel.h"


#pragma mark - 声明
@interface HomeController()

@property (nonatomic, strong) HomeNavigation *navigation;
@property (nonatomic, strong) HomeHeader *header;
@property (nonatomic, strong) HomeList *list;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSMutableArray<BKMonthModel *> *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation HomeController


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




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self syncedDataRequest];
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


// 同步数据
- (void)syncedDataRequest {
    
    // 类别
    // 系统 - 添加的 - 支出
    NSMutableArray<BKCModel *> *cateSysHasPayArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_Has_PAY_SYNCED];
    // 系统 - 删除的 - 支出
    NSMutableArray<BKCModel *> *cateSysRemovePayArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
    // 用户 - 添加的 - 支出
    NSMutableArray<BKCModel *> *cateCusHasPayArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
    // 用户 - 删除的 - 支出
    NSMutableArray<BKCModel *> *cateCusRemovePayArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
    
    
    // 系统 - 添加的 - 收入
    NSMutableArray<BKCModel *> *cateSysHasIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
    // 系统 - 删除的 - 收入
    NSMutableArray<BKCModel *> *cateSysRemoveIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
    // 用户 - 添加的 - 收入
    NSMutableArray<BKCModel *> *cateCusHasIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
    // 用户 - 删除的 - 收入
    NSMutableArray<BKCModel *> *cateCusRemoveIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];
    
    
    // 记账信息
    NSMutableArray<BKModel *> *bookArr = [NSUserDefaults objectForKey:PIN_BOOK_SYNCED];
    
    
    // 声音开关
    NSNumber *sound = [NSUserDefaults objectForKey:PIN_SETTING_SOUND_SYNCED];
    // 明细详情
    NSNumber *detail = [NSUserDefaults objectForKey:PIN_SETTING_DETAIL_SYNCED];
    
    
    // 定时
    NSMutableArray *timing_has = [NSUserDefaults objectForKey:PIN_TIMING_HAS_SYNCED];
    NSMutableArray *timing_remove = [NSUserDefaults objectForKey:PIN_TIMING_REMOVE_SYNCED];
    
    
    // 参数
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateSysRemovePayArr] mj_JSONString], @"cateSysRemovePayArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateSysHasPayArr] mj_JSONString], @"cateSysHasPayArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateCusRemovePayArr] mj_JSONString], @"cateCusRemovePayArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateCusHasPayArr] mj_JSONString], @"cateCusHasPayArr",
//
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateSysRemoveIncomeArr] mj_JSONString], @"cateSysRemoveIncomeArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateSysHasIncomeArr] mj_JSONString], @"cateSysHasIncomeArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateCusRemoveIncomeArr] mj_JSONString], @"cateCusRemoveIncomeArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateCusHasIncomeArr] mj_JSONString], @"cateCusHasIncomeArr",

                                  [[BKModel mj_keyValuesArrayWithObjectArray:bookArr] mj_JSONString], @"book",
                                  sound, @"sound",
                                  detail, @"detail",
                                  [timing_has mj_JSONString], @"timing_has",
                                  [timing_remove mj_JSONString], @"timing_remove",
                                  nil];
    
    
    
    
    
    @weakify(self)
    [self showTextHUD:@"同步中...."];
    [AFNManager POST:SyncedDataRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        // 成功
        if (result.status == ServiceCodeSuccess) {
            
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_PAY_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY_SYNCED];

            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];

            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_BOOK_SYNCED];

            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_TIMING_HAS_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_TIMING_REMOVE_SYNCED];
            
            
            
            
            NSString *systemCatePath = [[NSBundle mainBundle] pathForResource:@"SC" ofType:@"plist"];
            NSDictionary *systemCateDic = [NSDictionary dictionaryWithContentsOfFile:systemCatePath];
            NSMutableArray<BKCModel *> *pay = [NSMutableArray arrayWithArray:systemCateDic[@"pay"]];
            NSMutableArray<BKCModel *> *income = [NSMutableArray arrayWithArray:systemCateDic[@"income"]];
            pay = [BKCModel mj_objectArrayWithKeyValuesArray:pay];
            income = [BKCModel mj_objectArrayWithKeyValuesArray:income];

            NSMutableArray<BKCModel *> *payRemove = [NSMutableArray array];
            NSMutableArray<BKCModel *> *incomeRemove = [NSMutableArray array];

            NSArray<NSArray *> *arr = result.data[@"delete_cate"];
            for (NSArray *subarr in arr) {
                NSInteger category_id = [subarr[0] integerValue];
                NSString *preStr = [NSString stringWithFormat:@"Id == %ld", category_id];
                NSPredicate *pre = [NSPredicate predicateWithFormat:preStr];
                if (category_id <= [pay lastObject].Id) {
                    NSArray<BKModel *> *models = (NSArray *)[pay filteredArrayUsingPredicate:pre];
                    BKModel *model = [models firstObject];
                    [pay removeObject:model];
                    [payRemove addObject:model];
                } else {
                    NSArray<BKModel *> *models = (NSArray *)[income filteredArrayUsingPredicate:pre];
                    BKModel *model = [models firstObject];
                    [income removeObject:model];
                    [incomeRemove addObject:model];
                }
            }
            
            [NSUserDefaults setObject:pay forKey:PIN_CATE_SYS_HAS_PAY];
            [NSUserDefaults setObject:payRemove forKey:PIN_CATE_SYS_REMOVE_PAY];

            [NSUserDefaults setObject:income forKey:PIN_CATE_SYS_HAS_INCOME];
            [NSUserDefaults setObject:incomeRemove forKey:PIN_CATE_SYS_REMOVE_INCOME];
            
            
            
            NSMutableArray *insertArr = result.data[@"insert_cate"];
            NSMutableArray<BKCModel *> *insertPayModel = [NSMutableArray array];
            NSMutableArray<BKCModel *> *insertIncomeModel = [NSMutableArray array];
            for (NSArray *arr in insertArr) {
                BKCModel *model = [[BKCModel alloc] init];
                model.Id = [arr[0] integerValue];
                model.name = arr[1];
                model.icon_n = arr[2];
                model.icon_l = arr[3];
                model.icon_s = arr[4];
                model.is_income = [arr[5] boolValue];
                model.is_system = [arr[6] boolValue];
                if ([param[@"is_income"] boolValue] == true) {
                    [insertIncomeModel addObject:model];
                } else {
                    [insertPayModel addObject:model];
                }
            }
            [NSUserDefaults setObject:insertPayModel forKey:PIN_CATE_CUS_HAS_PAY];
            [NSUserDefaults setObject:insertIncomeModel forKey:PIN_CATE_CUS_HAS_INCOME];
            
            
            
            NSArray *setting = result.data[@"setting"][0];
            NSNumber *sound = setting[0];
            NSNumber *detail = setting[1];
            [NSUserDefaults setObject:sound forKey:PIN_SETTING_SOUND];
            [NSUserDefaults setObject:detail forKey:PIN_SETTING_DETAIL];
            
            
            
            NSArray<NSArray *> *bookarr = result.data[@"book"];
            NSMutableArray<BKModel *> *bookModels = [NSMutableArray array];
            for (NSArray *subarr in bookarr) {
                BKModel *model = [[BKModel alloc] init];
                model.Id = random() % 1000000000;
                model.price = [subarr[0] floatValue];
                model.category_id = [subarr[1] integerValue];
                model.year = [subarr[2] integerValue];
                model.month = [subarr[3] integerValue];
                model.day = [subarr[4] integerValue];
                model.mark = subarr[5];
                model.cmodel = ({
                    BKCModel *submodel = [[BKCModel alloc] init];
                    submodel.Id = [subarr[1] integerValue];
                    submodel.name = subarr[8];
                    submodel.icon_n = subarr[9];
                    submodel.icon_l = subarr[10];
                    submodel.icon_s = subarr[11];
                    submodel.is_income = [subarr[6] boolValue];
                    submodel.is_system = [subarr[7] boolValue];
                    submodel;
                });
                [bookModels addObject:model];
            }
            [NSUserDefaults setObject:bookModels forKey:PIN_BOOK];
            
            
            
            UserModel *model = [UserInfo loadUserInfo];
            model.sound = [sound integerValue];
            model.detail = [detail integerValue];
            [UserInfo saveUserModel:model];
            
        }
        // 失败
        else {
            [self showTextHUD:result.message delay:1.5f];
        }
    }];
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
    NSMutableArray<BKModel *> *bookArrm = [NSUserDefaults objectForKey:PIN_BOOK];
    NSMutableArray<BKModel *> *bookSyncedArrm = [NSUserDefaults objectForKey:PIN_BOOK_SYNCED];
    if ([bookSyncedArrm containsObject:cell.model]) {
        [bookSyncedArrm removeObject:cell.model];
    }
    [bookArrm removeObject:cell.model];
    [NSUserDefaults setObject:bookArrm forKey:PIN_BOOK];
    [NSUserDefaults setObject:bookArrm forKey:PIN_BOOK_SYNCED];
    
    // 更新
    [[NSNotificationCenter defaultCenter] postNotificationName:NOT_BOOK_DELETE object:nil];
}
// 点击Cell
- (void)homeTableCellClick:(BKModel *)model {
    NSNumber *detail = [NSUserDefaults objectForKey:PIN_SETTING_DETAIL];
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
