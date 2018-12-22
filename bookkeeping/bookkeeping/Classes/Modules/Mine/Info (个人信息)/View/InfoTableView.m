/**
 * 列表
 * @author 郑业强 2018-12-22 创建文件
 */

#import "InfoTableView.h"
#import "InfoTableCell.h"
#import "InfoFooter.h"
#import "INFO_EVENT_MANAGER.h"


#pragma mark - 声明
@interface InfoTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *arr;

@end


#pragma mark - 实现
@implementation InfoTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kColor_Line_Color;
        self.contentInset = UIEdgeInsetsMake(countcoordinatesX(10), 0, 0, 0);
        self.separatorColor = kColor_BG;
        [self lineAll];
        [self lineHide];
    }
    return self;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableCell *cell = [InfoTableCell loadFirstNib:tableView];
    cell.indexPath = indexPath;
    cell.name = self.arr[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self routerEventWithName:INFO_CELL_CLICK data:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    InfoFooter *view = [InfoFooter loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(60))];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return countcoordinatesX(60);
}


#pragma mark - get
- (NSArray *)arr {
    if (!_arr) {
        _arr = @[@"头像", @"ID", @"昵称", @"性别", @"手机号", @"微信"];
    }
    return _arr;
}


@end
