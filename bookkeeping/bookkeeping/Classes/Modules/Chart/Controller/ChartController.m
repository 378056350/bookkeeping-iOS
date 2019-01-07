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
#import "BKModel.h"


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
    [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex date:self.date]];
}
// 监听通知
- (void)monitorNotification {
    // 记账完成
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOT_BOOK_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self setDate:[NSDate date]];
        [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex date:self.date]];
        [self updateDateRange];
    }];
}
// 更新时间范围
- (void)updateDateRange {
    // 收入
    NSInteger is_income = _navigationIndex == 1;
    NSMutableArray<BKModel *> *bookArr = [[PINDiskCache sharedCache] objectForKey:PIN_BOOK];
    NSString *preStr = [NSString stringWithFormat:@"cmodel.is_income == %ld", is_income];
    NSPredicate *pre = [NSPredicate predicateWithFormat:preStr];
    NSMutableArray<BKModel *> *models = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
    // 最小时间
    _minModel = ({
        NSDate *minDate = [models valueForKeyPath:@"@min.date"];
        if (minDate) {
            preStr = [NSString stringWithFormat:@"year == %ld AND month == %02ld AND day == %02ld", minDate.year, minDate.month, minDate.day];
        }
        pre = [NSPredicate predicateWithFormat:preStr];
        NSArray *arr = [models filteredArrayUsingPredicate:pre];
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
        pre = [NSPredicate predicateWithFormat:preStr];
        NSArray *arr = [models filteredArrayUsingPredicate:pre];
        BKModel *model;
        if (arr.count != 0) {
            model = arr[0];
        }
        model;
    });
    
    
    _subdate.minModel = _minModel;
    _subdate.maxModel = _maxModel;
}


#pragma mark - 请求
// 时间范围
- (void)bookRangeRequest {
//    @weakify(self)
//    [AFNManager POST:GetBookRangeRequest params:nil complete:^(APPResult *result) {
//        @strongify(self)
//        if (result.status == ServiceCodeSuccess) {
//            [self setTimeModel:[ChartRangeModel mj_objectWithKeyValues:result.data]];
//        } else {
//            [self showTextHUD:result.message delay:1.f];
//        }
//    }];
}
// 查账
- (void)bookRequest {
//    NSMutableDictionary *param = ({
//        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//        [param setObject:@(self.navigation.navigationIndex) forKey:@"isIncome"];
//        [param setObject:@(1) forKey:@"hasList"];
//        [param setObject:@(1) forKey:@"hasGroup"];
//        if (_seg.seg.selectedSegmentIndex == 0) {
//            [param setObject:@([self.date year]) forKey:@"year"];
//            [param setObject:@([self.date month]) forKey:@"month"];
//            [param setObject:@([self.date day]) forKey:@"day"];
//            [param setObject:@([self.date weekOfYear]) forKey:@"week"];
//            [param setObject:@(1) forKey:@"week_year"];
//        } else if (_seg.seg.selectedSegmentIndex == 1) {
//            [param setObject:@([self.date year]) forKey:@"year"];
//            [param setObject:@([self.date month]) forKey:@"month"];
//        } else if (_seg.seg.selectedSegmentIndex == 2) {
//            [param setObject:@([self.date year]) forKey:@"year"];
//        }
//        param;
//    });
//    @weakify(self)
//    [AFNManager POST:GetBookRequest params:param complete:^(APPResult *result) {
//        @strongify(self)
//        // 成功
//        if (result.status == ServiceCodeSuccess) {
//            [self setModel:[BKModel mj_objectWithKeyValues:result.data]];
//        }
//        // 失败
//        else {
//            [self showWindowTextHUD:result.message delay:1.f];
//        }
//    }];
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
            [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex date:self.date]];
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
            [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex date:self.date]];
        }];
        [self.view addSubview:_subdate];
    }
    return _subdate;
}
- (ChartTableView *)table {
    if (!_table) {
        _table = [ChartTableView initWithFrame:({
            CGFloat top = self.subdate.bottom;
            CGFloat height = SCREEN_HEIGHT - top - TabbarHeight;
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
            [self setModel:[BKChartModel statisticalChart:self.segmentIndex isIncome:self.navigationIndex date:self.date]];
        }];
        [self.view addSubview:_chud];
    }
    return _chud;
}


@end
