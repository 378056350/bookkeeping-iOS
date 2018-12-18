/**
 * 图表
 * @author 郑业强 2018-12-16 创建文件
 */

#import "ChartController.h"
#import "ChartNavigation.h"
#import "ChartDate.h"
#import "ChartSubDate.h"
#import "ChartTableView.h"


#pragma mark - 声明
@interface ChartController()

@property (nonatomic, strong) ChartNavigation *navigation;
@property (nonatomic, strong) ChartDate *date;
@property (nonatomic, strong) ChartSubDate *subdate;
@property (nonatomic, strong) ChartTableView *table;

@end


#pragma mark - 实现
@implementation ChartController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self.navigationItem setTitleView:self.navigation];
    [self date];
    [self subdate];
    [self table];
}


#pragma mark - get
- (ChartNavigation *)navigation {
    if (!_navigation) {
        _navigation = [ChartNavigation loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }
    return _navigation;
}
- (ChartDate *)date {
    if (!_date) {
        _date = [ChartDate loadFirstNib:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, countcoordinatesX(50))];
        [self.view addSubview:_date];
    }
    return _date;
}
- (ChartSubDate *)subdate {
    if (!_subdate) {
        _subdate = [ChartSubDate loadCode:CGRectMake(0, _date.bottom, SCREEN_WIDTH, countcoordinatesX(50))];
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


@end
