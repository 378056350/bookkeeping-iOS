/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "CategoryTable.h"
#import "CategoryCell.h"

#pragma mark - 声明
@interface CategoryTable()<UITableViewDelegate, UITableViewDataSource>

@end


#pragma mark - 实现
@implementation CategoryTable


+ (instancetype)initWithFrame:(CGRect)frame {
    CategoryTable *table = [[CategoryTable alloc] initWithFrame:frame style:UITableViewStylePlain];
    [table setDelegate:table];
    [table setDataSource:table];
    [table lineHide];
    [table lineAll];
    [table setBackgroundColor:kColor_BG];
    [table setSeparatorColor:kColor_BG];
    [table setTableHeaderView:({
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(10))];
        header;
    })];
    [table setTableFooterView:({
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(20))];
        header;
    })];
    return table;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [CategoryCell loadFirstNib:tableView];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}


@end
