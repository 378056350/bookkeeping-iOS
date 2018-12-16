/**
 * 我的列表
 * @author 郑业强 2018-12-16 创建文件
 */

#import "MineTableView.h"
#import "MineTableCell.h"
#import "MineTableHeader.h"

#pragma mark - 声明
@interface MineTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MineTableHeader *header;
@property (nonatomic, strong) NSArray<NSArray<NSArray *> *> *datas;

@end


#pragma mark - 实现
@implementation MineTableView


+ (instancetype)initWithFrame:(CGRect)frame {
    MineTableView *table = [[MineTableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [table setDelegate:table];
    [table setDataSource:table];
    [table lineHide];
    [table lineAll];
    [table setTableHeaderView:[table header]];
    [table setShowsVerticalScrollIndicator:NO];
    [table setShowsHorizontalScrollIndicator:NO];
    return table;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas[0].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas[0][section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableCell *cell = [MineTableCell loadFirstNib:tableView];
    cell.nameLab.text = self.datas[0][indexPath.section][indexPath.row];
    cell.icon.image = [UIImage imageNamed:self.datas[1][indexPath.section][indexPath.row]];
    cell.status = [self.datas[2][indexPath.section][indexPath.row] integerValue];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return countcoordinatesX(10);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - get
- (MineTableHeader *)header {
    if (!_header) {
        _header = [MineTableHeader loadCode:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 3 * 2)];
    }
    return _header;
}
- (NSArray<NSArray<NSArray *> *> *)datas {
    if (!_datas) {
        _datas = @[
                   @[
                       @[@"徽章"],
                       @[@"类别设置",@"定时提醒",@"声音开关",@"明细详情"],
                       @[@"去App Store给鲨鱼记账评分",@"意见反馈",@"帮助",@"关于鲨鱼记账"],
                       ],
                   @[
                       @[@"111"],
                       @[@"111",@"111",@"111",@"111"],
                       @[@"111",@"111",@"111",@"111",@"111"],
                       ],
                   @[
                       @[@(0)],
                       @[@(0),@(0),@(1),@(1)],
                       @[@(0),@(0),@(0),@(0),@(0)],
                       ]
                   ];
    }
    return _datas;
}


@end
