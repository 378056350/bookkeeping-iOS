/**
 * 首页
 * @author 郑业强 2018-12-16 创建文件
 */

#import "HomeController.h"
#import "HomeHeader.h"
#import "HomeList.h"
#import "LoginController.h"
#import "BookMonthModel.h"
#import "HOME_EVENT_MANAGER.h"


#pragma mark - 声明
@interface HomeController()

@property (nonatomic, strong) HomeHeader *header;
@property (nonatomic, strong) HomeList *list;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSMutableArray<BookMonthModel *> *datas;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<BookMonthModel *> *> *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation HomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_share_shark"]]];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self header];
    [self list];
    [self setDate:[NSDate date]];
    [self getBookRequest:self.date];
    [self monitorNotification];

}
// 监听通知
- (void)monitorNotification {
    // 登录完成
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOT_BOOK_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self getBookRequest:self.date];
    }];
}


#pragma mark - 请求
// 查账
- (void)getBookRequest:(NSDate *)date {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @(date.year), @"year",
                           @(date.month), @"month", nil];
    @weakify(self)
    [AFNManager POST:GetBookMonthRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        // 成功
        if (result.status == ServiceCodeSuccess) {
            [self setDatas:[BookMonthModel mj_objectArrayWithKeyValuesArray:result.data]];
            [self setDate:date];
        }
        // 失败
        else {
            [self showWindowTextHUD:result.message delay:1.f];
        }
    }];
}


#pragma mark - set
- (void)setDatas:(NSMutableArray<BookMonthModel *> *)datas {
    _datas = datas;
    CGFloat income = 0;
    CGFloat pay = 0;
    if (datas.count != 0) {
        NSMutableArray<NSMutableArray<BookMonthModel *> *> *arrm = [NSMutableArray array];
        [arrm addObject:[NSMutableArray array]];
        
        NSInteger day = datas[0].day;
        for (BookMonthModel *model in datas) {
            if (model.day == day) {
                [[arrm lastObject] addObject:model];
            } else {
                day = model.day;
                [arrm addObject:[NSMutableArray array]];
                [[arrm lastObject] addObject:model];
            }
            
            if (model.is_income == 0) {
                pay += model.price;
            } else {
                income += model.price;
            }
        }
        [self setModels:arrm];
    } else {
        [self setModels:[NSMutableArray array]];
    }
    
    [self.header setPay:pay];
    [self.header setIncome:income];
    
}
- (void)setModels:(NSMutableArray<NSMutableArray<BookMonthModel *> *> *)models {
    _models = models;
    _list.models = models;
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
    NSDate *max = [NSDate br_setYear:date.year + 3 month:12 day:31];
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYM defaultSelValue:[date formatYM] minDate:min maxDate:max isAutoSelect:false themeColor:nil resultBlock:^(NSString *selectValue) {
        @strongify(self)
        [self setDate:({
            NSDateFormatter *fora = [[NSDateFormatter alloc] init];
            [fora setDateFormat:@"yyyy-MM"];
            NSDate *date = [fora dateFromString:selectValue];
            date;
        })];
        [self getBookRequest:self.date];
    }];
}
// 下拉
- (void)homeTablePull:(id)data {
    NSDate *next = [self.date offsetMonths:1];
    [self getBookRequest:next];
}
// 上拉
- (void)homeTableUp:(id)data {
    NSDate *last = [self.date offsetMonths:-1];
    [self getBookRequest:last];
}


#pragma mark - get
- (HomeHeader *)header {
    if (!_header) {
        _header = [HomeHeader loadFirstNib:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, countcoordinatesX(64))];
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
                           };
    }
    return _eventStrategy;
}


@end
