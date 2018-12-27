/**
 * 我的
 * @author 郑业强 2018-12-16 创建文件
 */


#import "MineView.h"
#import "MineHeader.h"
#import "MINE_EVENT_MANAGER.h"


#pragma mark - 声明
@interface MineView()

@property (nonatomic, strong) MineHeader *header;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation MineView


- (void)initUI {
    [self table];
    [self header];
}


#pragma mark - set
- (void)setModel:(UserModel *)model {
    _model = model;
    _table.model = model;
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
// table滚动
- (void)mineDidScroll:(UITableView *)table {
    _header.alpha = table.contentOffset.y / (_table.tableHeaderView.height - _header.height);
}


#pragma mark - get
- (MineHeader *)header {
    if (!_header) {
        _header = [MineHeader loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight)];
        [self addSubview:_header];
    }
    return _header;
}
- (MineTableView *)table {
    if (!_table) {
        _table = [MineTableView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabbarHeight)];
        [_table setSeparatorColor:kColor_BG];
        [self addSubview:_table];
    }
    return _table;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           MINE_DID_SCROLL: [self createInvocationWithSelector:@selector(mineDidScroll:)],
                           
                           };
    }
    return _eventStrategy;
}


@end
