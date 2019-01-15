/**
 * 列表cell
 * @author 郑业强 2018-12-17 创建文件
 */

#import "HomeListCell.h"
#import "KKRefreshNormalHeader.h"
#import "KKRefreshNormalFooter.h"
#import "HomeListHeader.h"
#import "HomeListSubCell.h"
#import "HomeListEmpty.h"
#import "HOME_EVENT.h"

#pragma mark - 声明
@interface HomeListCell()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) KKRefreshNormalHeader *header;
@property (nonatomic, strong) KKRefreshNormalFooter *footer;
@property (nonatomic, strong) HomeListEmpty *emptyView;

@end


#pragma mark - 实现
@implementation HomeListCell


- (void)initUI {
    [self setBackgroundColor:[UIColor brownColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self table];
    [self emptyView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.table setFrame:self.contentView.bounds];
    [self.emptyView setFrame:self.contentView.bounds];
}


#pragma mark - set
- (void)setModels:(NSMutableArray<BKMonthModel *> *)models {
    _models = models;
    [self.table reloadData];
    [self.emptyView setHidden:models.count != 0];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models ? self.models.count : 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models[section].list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListSubCell *cell = [HomeListSubCell loadFirstNib:tableView];
    cell.model = self.models[indexPath.section].list[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeListHeader *header = [HomeListHeader loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(30))];
    header.model = self.models[section];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return countcoordinatesX(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(5))];
    view.backgroundColor = kColor_White;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return countcoordinatesX(5);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BKModel *model = self.models[indexPath.section].list[indexPath.row];
    [self routerEventWithName:HOME_CELL_CLICK data:model];
}


- (void)endRefresh {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
}


#pragma mark - get
- (KKRefreshNormalHeader *)header {
    if (!_header) {
        __weak typeof(self) weak = self;
        _header = [KKRefreshNormalHeader headerWithRefreshingBlock:^{
            [weak routerEventWithName:HOME_TABLE_PULL data:nil];
        }];
    }
    return _header;
}
- (KKRefreshNormalFooter *)footer {
    if (!_footer) {
        __weak typeof(self) weak = self;
        _footer = [KKRefreshNormalFooter footerWithRefreshingBlock:^{
            [weak routerEventWithName:HOME_TABLE_UP data:nil];
        }];
    }
    return _footer;
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_table setMj_header:self.header];
        [_table setMj_footer:self.footer];
        [_table lineHide];
        [_table lineAll];
        [_table setDelegate:self];
        [_table setDataSource:self];
        [_table setShowsVerticalScrollIndicator:false];
        [_table setSeparatorColor:kColor_Line_Color];
        [_table setBackgroundColor:kColor_White];
        [_table setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)]];
        [self.contentView addSubview:_table];
    }
    return _table;
}
- (HomeListEmpty *)emptyView {
    if (!_emptyView) {
        _emptyView = [HomeListEmpty loadFirstNib:self.bounds];
        _emptyView.hidden = true;
        [self.table addSubview:_emptyView];
    }
    return _emptyView;
}


@end
