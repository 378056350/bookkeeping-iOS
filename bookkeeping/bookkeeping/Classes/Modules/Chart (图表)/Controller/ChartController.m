/**
 * 图表
 * @author 郑业强 2018-12-16 创建文件
 */

#import "ChartController.h"
#import "ChartNavigation.h"
#import "ChartSegmentControl.h"
#import "ChartDate.h"
#import "ChartTableView.h"
#import "ChartHUD.h"
#import "ChartTableCell.h"
#import "CHART_EVENT.h"
#import "LOGIN_NOTIFICATION.h"
#import "BDController.h"


#pragma mark - 声明
@interface ChartController()

@property (nonatomic, strong) ChartNavigation *navigation;
@property (nonatomic, strong) ChartSegmentControl *seg;
@property (nonatomic, strong) ChartDate *subdate;
@property (nonatomic, strong) ChartHUD *chud;
@property (nonatomic, strong) ChartTableView *table;

@property (nonatomic, assign) NSInteger navigationIndex;
@property (nonatomic, assign) NSInteger segmentIndex;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) BKChartModel *model;
@property (nonatomic, strong) BKModel *minModel;
@property (nonatomic, strong) BKModel *maxModel;

@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation ChartController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:true];
    [self setDate:[NSDate date]];
    [self navigation];
    [self seg];
    [self subdate];
    [self table];
    [self chud];
    [self setNavigationIndex:0];
    
    [self updateDateRange];
    [self monitorNotification];
    [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex cmodel:self.cmodel date:self.date]];
}
// 监听通知
- (void)monitorNotification {
    // 记账
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOT_BOOK_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self setDate:[NSDate date]];
        [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex cmodel:self.cmodel date:self.date]];
        [self updateDateRange];
    }];
    // 删除记账
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOT_BOOK_DELETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self setDate:[NSDate date]];
        [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex cmodel:self.cmodel date:self.date]];
        [self updateDateRange];
    }];
    // 退出登录
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOPGIN_LOGOUT_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self setDate:[NSDate date]];
        [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex cmodel:self.cmodel date:self.date]];
        [self updateDateRange];
    }];
    // 同步数据成功
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:SYNCED_DATA_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self setDate:[NSDate date]];
        [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex cmodel:self.cmodel date:self.date]];
        [self updateDateRange];
    }];
}
// 更新时间范围
- (void)updateDateRange {
    // 收入
    NSInteger is_income = _navigationIndex == 1;
    NSMutableArray<BKModel *> *bookArr = [NSUserDefaults objectForKey:PIN_BOOK];
    NSString *preStr = [NSString stringWithFormat:@"cmodel.is_income == %ld", is_income];
    if (_cmodel) {
        preStr = [preStr stringByAppendingString:[NSString stringWithFormat:@" AND cmodel.Id == %ld", _cmodel.cmodel.Id]];
    }
    NSMutableArray<BKModel *> *models = [NSMutableArray kk_filteredArrayUsingPredicate:preStr array:bookArr];
    // 最小时间
    _minModel = ({
        NSDate *minDate = [models valueForKeyPath:@"@min.date"];
        if (minDate) {
            preStr = [NSString stringWithFormat:@"year == %ld AND month == %02ld AND day == %02ld", minDate.year, minDate.month, minDate.day];
        }
        NSMutableArray *arr = [NSMutableArray kk_filteredArrayUsingPredicate:preStr array:models];
        BKModel *model;
        if (arr.count != 0) {
            model = arr[0];
        }
        model;
    });
    // 最大时间
    _maxModel = ({
        NSDate *maxDate = [models valueForKeyPath:@"@max.date"];
        if (maxDate) {
            preStr = [NSString stringWithFormat:@"year == %ld AND month == %02ld AND day == %02ld", maxDate.year, maxDate.month, maxDate.day];
        }
        NSMutableArray *arr = [NSMutableArray kk_filteredArrayUsingPredicate:preStr array:models];
        BKModel *model;
        if (arr.count != 0) {
            model = arr[0];
        }
        model;
    });
    
    
    _subdate.minModel = _minModel;
    _subdate.maxModel = _maxModel;
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
// 点击Cell
- (void)chartTableClick:(NSIndexPath *)indexPath {
    BKModel *model = self.model.groupArr[indexPath.row];
    if (!_cmodel) {
        ChartController *vc = [[ChartController alloc] init];
        vc.cmodel = model;
        [self.navigationController pushViewController:vc animated:true];
    } else {
        BDController *vc = [[BDController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:true];
    }
}


#pragma mark - set
- (void)setModel:(BKChartModel *)model {
    _model = model;
    _table.model = model;
}
- (void)setNavigationIndex:(NSInteger)navigationIndex {
    _navigationIndex = navigationIndex;
    _navigation.navigationIndex = navigationIndex;
    _subdate.navigationIndex = navigationIndex;
    _table.navigationIndex = navigationIndex;
}
- (void)setSegmentIndex:(NSInteger)segmentIndex {
    _segmentIndex = segmentIndex;
    _subdate.segmentIndex = segmentIndex;
    _table.segmentIndex = segmentIndex;
}


#pragma mark - get
- (ChartNavigation *)navigation {
    if (!_navigation) {
        @weakify(self)
        _navigation = [ChartNavigation loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight)];
        [_navigation setCmodel:_cmodel];
        [[_navigation.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIControl *button) {
            @strongify(self)
            [self.chud show];
        }];
        [self.view addSubview:_navigation];
    }
    return _navigation;
}
- (ChartSegmentControl *)seg {
    if (!_seg) {
        @weakify(self)
        _seg = [ChartSegmentControl loadFirstNib:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, countcoordinatesX(50))];
        [[_seg.seg rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISegmentedControl *seg) {
            @strongify(self)
            [self setDate:({
                NSInteger index = seg.selectedSegmentIndex;
                NSIndexPath *indexPath = self.subdate.selectIndexs[index];
                ChartSubModel *model = self.subdate.sModels[index][indexPath.row];
                NSInteger month = model.month == -1 ? 1 : model.month;
                NSInteger day = model.day == -1 ? 1 : model.day;
                NSDate *date = [NSDate dateWithYMD:[NSString stringWithFormat:@"%ld-%02ld-%02ld", model.year, month, day]];
                date;
            })];
            [self setSegmentIndex:seg.selectedSegmentIndex];
            [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex cmodel:self.cmodel date:self.date]];
        }];
        [self.view addSubview:_seg];
    }
    return _seg;
}
- (ChartDate *)subdate {
    if (!_subdate) {
        @weakify(self)
        _subdate = [ChartDate loadCode:CGRectMake(0, _seg.bottom, SCREEN_WIDTH, countcoordinatesX(45))];
        [_subdate setComplete:^(ChartSubModel *model) {
            @strongify(self)
            NSInteger month = model.month == -1 ? 1 : model.month;
            NSInteger day = model.day == -1 ? 1 : model.day;
            NSString *str = [NSString stringWithFormat:@"%ld-%02ld-%02ld", model.year, month, day];
            [self setDate:[NSDate dateWithYMD:str]];
            [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex cmodel:self.cmodel date:self.date]];
        }];
        [self.view addSubview:_subdate];
    }
    return _subdate;
}
- (ChartTableView *)table {
    if (!_table) {
        _table = [ChartTableView initWithFrame:({
            CGFloat top = self.subdate.bottom;
            CGFloat height = SCREEN_HEIGHT - top;
            height -= self.navigationController.viewControllers.count == 1 ? TabbarHeight : 0;
            CGRectMake(0, top, SCREEN_WIDTH, height);
        })];
        [self.view addSubview:_table];
    }
    return _table;
}
- (ChartHUD *)chud {
    if (!_chud) {
        @weakify(self)
        _chud = [ChartHUD loadCode:CGRectMake(0, _seg.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _seg.bottom - TabbarHeight)];
        [_chud setComplete:^(NSInteger index) {
            @strongify(self)
            [self setNavigationIndex:index];
            [self updateDateRange];
            [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex cmodel:self.cmodel date:self.date]];
        }];
        [self.view addSubview:_chud];
    }
    return _chud;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           CHART_TABLE_CLICK: [self createInvocationWithSelector:@selector(chartTableClick:)]
                           };
    }
    return _eventStrategy;
}


@end
