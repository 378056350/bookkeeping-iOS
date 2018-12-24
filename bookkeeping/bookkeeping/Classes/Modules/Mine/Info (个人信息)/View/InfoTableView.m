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

@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *arr;

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableCell *cell = [InfoTableCell loadFirstNib:tableView];
    cell.indexPath = indexPath;
    cell.name = self.arr[indexPath.section][indexPath.row];
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
    if (section == 1) {
        InfoFooter *view = [InfoFooter loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(60))];
        return view;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return countcoordinatesX(60);
    }
    return 0.01f;
}


#pragma mark - get
- (NSArray<NSArray<NSString *> *> *)arr {
    if (!_arr) {
        _arr = @[
                 @[@"头像", @"ID", @"昵称", @"性别", @"手机号", @"微信"],
                 @[@"修改密码"]
                 ];
    }
    return _arr;
}


@end
