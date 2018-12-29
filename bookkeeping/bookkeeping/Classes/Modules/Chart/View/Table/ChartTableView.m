/**
 * 列表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "ChartTableView.h"
#import "ChartTableCell.h"
#import "ChartTableHeader.h"
#import "ChartSectionHeader.h"


#pragma mark - 声明
@interface ChartTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ChartTableHeader *tHeader;

@end


#pragma mark - 实现
@implementation ChartTableView


+ (instancetype)initWithFrame:(CGRect)frame {
    ChartTableView *table = [[ChartTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [table setDelegate:table];
    [table setDataSource:table];
    [table lineHide];
    [table lineAll];
    [table setSeparatorColor:kColor_BG];
    [table setTableHeaderView:[table tHeader]];
    return table;
}


#pragma mark - set
- (void)setModels:(NSMutableArray<ChartModel *> *)models {
    _models = models;
    _tHeader.models = models;
    [self reloadData];
}
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    [self reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChartTableCell *cell = [ChartTableCell loadFirstNib:tableView];
    cell.model = self.models[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ChartSectionHeader *header = [ChartSectionHeader loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(40))];
    header.selectIndex = _selectIndex;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return countcoordinatesX(50);
}


#pragma mark - get
- (ChartTableHeader *)tHeader {
    if (!_tHeader) {
        _tHeader = [ChartTableHeader loadCode:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 2)];
    }
    return _tHeader;
}


@end
