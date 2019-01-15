/**
 * 图表弹框内容
 * @author 郑业强 2018-12-30 创建文件
 */

#import "BCHUDContent.h"
#import "BCHUDContentCell.h"

#pragma mark - 声明
@interface BCHUDContent()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UILabel *lab;

@end

#pragma mark - 实现
@implementation BCHUDContent

- (void)initUI {
    [self setBackgroundColor:kColor_Text_Black];
    [self.layer setCornerRadius:3];
    [self table];
    [self lab];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.table setFrame:({
        CGFloat left = countcoordinatesX(10);
        CGFloat top = countcoordinatesX(10);
        CGFloat width = self.width - left * 2;
        CGFloat height = self.height - top * 2;
        CGRectMake(left, top, width, height);
    })];
    [self.lab setFrame:self.bounds];
}

#pragma mark - set
- (void)setModels:(NSMutableArray<BKModel *> *)models {
    _models = models;
    [self.table reloadData];
    [self.lab setHidden:models.count != 0];
    [self.table setHidden:models.count == 0];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count > 3 ? 3 : self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BCHUDContentCell *cell = [BCHUDContentCell loadFirstNib:tableView];
    cell.model = self.models[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(20);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return countcoordinatesX(5);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    
    UILabel *lab = [[UILabel alloc] initWithFrame:({
        CGRectMake(0, 0, _table.width, countcoordinatesX(20));
    })];
//    lab.textColor = kColor_Chart_Text;
//    lab.text = ({
//        CGFloat maxPrice = [[self.models valueForKeyPath:@"@sum.price.floatValue"] floatValue];
//        NSMutableString *strm = [[NSMutableString alloc] init];
//        if (_models.count != 0) {
//            BookListModel *model = _models[0];
//            if (model.is_income == 0) {
//                [strm appendString:@"当日总支出: "];
//            } else {
//                [strm appendString:@"当日总收入: "];
//            }[strm appendString:[@(maxPrice) description]];
//        }
//        strm;
//    });
//    lab.font = [UIFont systemFontOfSize:AdjustFont(8)];
//    lab.layer.cornerRadius = 3;
//    lab.layer.masksToBounds = true;
    return lab;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return countcoordinatesX(20);
}

#pragma mark - get
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:({
            CGFloat left = countcoordinatesX(10);
            CGFloat top = countcoordinatesX(10);
            CGFloat width = self.width - left * 2;
            CGFloat height = self.height - top * 2;
            CGRectMake(left, top, width, height);
        }) style:UITableViewStylePlain];
        [_table setDelegate:self];
        [_table setDataSource:self];
        [_table setTableHeaderView:({
            UILabel *lab = [[UILabel alloc] initWithFrame:({
                CGRectMake(0, 0, _table.width, countcoordinatesX(20));
            })];
            lab.backgroundColor = kColor_Chart_Header;
            lab.textColor = kColor_Chart_Text;
            lab.text = @"最大3笔交易";
            lab.font = [UIFont systemFontOfSize:AdjustFont(10)];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.layer.cornerRadius = 3;
            lab.layer.masksToBounds = true;
            lab;
        })];
        [_table lineHide];
        [_table lineAll];
        [_table setSeparatorColor:kColor_Text_Black];
        [_table setBackgroundColor:[UIColor clearColor]];
        [_table setEstimatedRowHeight:0];
        [_table setEstimatedSectionHeaderHeight:0];
        [_table setEstimatedSectionFooterHeight:0];
        [self addSubview:_table];
    }
    return _table;
}
- (UILabel *)lab {
    if (!_lab) {
        _lab = [[UILabel alloc] initWithFrame:self.bounds];
        _lab.text = @"没有费用";
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.textColor = kColor_Chart_Text;
        _lab.font = [UIFont systemFontOfSize:AdjustFont(10)];
        [self addSubview:_lab];
    }
    return _lab;
}


@end
