/**
 * 定时
 * @author 郑业强 2018-12-18 创建文件
 */

#import "TITableView.h"
#import "TITableCell.h"

#pragma mark - 声明
@interface TITableView()<UITableViewDelegate, UITableViewDataSource>

@end


#pragma mark - 实现
@implementation TITableView


+ (instancetype)initWithFrame:(CGRect)frame {
    TITableView *table = [[TITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [table setDelegate:table];
    [table setDataSource:table];
    [table lineAll];
    [table lineHide];
    [table setSeparatorColor:kColor_BG];
    [table setBackgroundColor:kColor_BG];
    [table setContentInset:UIEdgeInsetsMake(countcoordinatesX(10), 0, countcoordinatesX(10), 0)];
    return table;
}


#pragma mark - set
//- (void)setModels:(NSMutableArray<TIModel *> *)models {
//    _models = models;
//    [self reloadData];
//}
- (void)setModels:(NSMutableArray *)models {
    _models = models;
    [self reloadData];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TITableCell *cell = [TITableCell loadFirstNib:tableView];
    cell.time = self.models[indexPath.row];
//    cell.model = self.models[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}


#pragma mark - get



@end
