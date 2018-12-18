/**
 * 列表cell
 * @author 郑业强 2018-12-17 创建文件
 */

#import "HomeListCell.h"
#import "KKRefreshNormalHeader.h"
#import "HomeListHeader.h"
#import "HomeListSubCell.h"
#import "HOME_EVENT_MANAGER.h"

#pragma mark - 声明
@interface HomeListCell()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) KKRefreshNormalHeader *header;

@end


#pragma mark - 实现
@implementation HomeListCell


- (void)initUI {
    [self setBackgroundColor:[UIColor brownColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self table];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.table setFrame:self.contentView.bounds];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListSubCell *cell = [HomeListSubCell loadFirstNib:tableView];
    return cell;
}


#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeListHeader *header = [HomeListHeader loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(30))];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return countcoordinatesX(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return countcoordinatesX(10);
}


#pragma mark - get
- (KKRefreshNormalHeader *)header {
    if (!_header) {
        __weak typeof(self) weak = self;
        _header = [KKRefreshNormalHeader headerWithRefreshingBlock:^{
            [weak.table.mj_header endRefreshing];
            [weak routerEventWithName:HOME_HEADER_BEGIN_REFRESH data:nil];
        }];
    }
    return _header;
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_table setBackgroundColor:RGBA(random() % 255, random() % 255, random() % 255, 1)];
        [_table setMj_header:self.header];
        [_table setDelegate:self];
        [_table setDataSource:self];
        [_table lineHide];
        [_table lineAll];
        [_table setSeparatorColor:kColor_BG];
        [self.contentView addSubview:_table];
    }
    return _table;
}


@end
