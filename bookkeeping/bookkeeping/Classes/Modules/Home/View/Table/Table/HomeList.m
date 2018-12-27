/**
 * 列表
 * @author 郑业强 2018-12-16 创建文件
 */

#import "HomeList.h"
#import "HomeListCell.h"
#import "HOME_EVENT_MANAGER.h"


#pragma mark - 声明
@interface HomeList()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation HomeList


- (void)initUI {
    [self setBackgroundColor:kColor_BG];
    [self table];
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
- (void)tableHeaderRefresh:(id)data {
    [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListCell *cell = [HomeListCell loadCode:tableView];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.height;
}


#pragma mark - get
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_table setDelegate:self];
        [_table setDataSource:self];
        [_table setPagingEnabled:YES];
        [_table lineHide];
        [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_table setShowsVerticalScrollIndicator:NO];
        [_table setScrollEnabled:NO];
        [self addSubview:_table];
    }
    return _table;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           HOME_HEADER_BEGIN_REFRESH: [self createInvocationWithSelector:@selector(tableHeaderRefresh:)],
                           
                           };
    }
    return _eventStrategy;
}


@end
