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
@interface TIController()

@property (nonatomic, strong) TITableView *table;
@property (nonatomic, strong) BottomButton *bottom;
@property (nonatomic, strong) NSMutableArray<TIModel *> *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end

#pragma mark - 实现
@implementation TIController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"定时提醒"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self table];
    [self bottom];
    [self.view bringSubviewToFront:self.bottom];
    [self timeListRequest];
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
    @weakify(self)
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@(cell.model.Id), @"id", nil];
    [self showProgressHUD];
    [AFNManager POST:RemoveTimeRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        [self.models removeObject:cell.model];
        [self.table deleteRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
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
        [self addTimeRequest:selectValue];
    }];
}
// 删除cell
- (void)timeCellDelete:(TITableCell *)cell {
    [self deleteTimeRequest:cell];
}


#pragma mark - set
- (void)setModels:(NSMutableArray<TIModel *> *)models {
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
