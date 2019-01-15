/**
 * 记账
 * @author 郑业强 2018-12-16 创建文件
 */

#import "FindController.h"
#import "FindCell.h"
#import "FindFeatureCell.h"
#import "BillController.h"

#pragma mark - 声明
@interface FindController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end


#pragma mark - 实现
@implementation FindController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self table];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FindCell *cell = [FindCell loadFirstNib:tableView];
        return cell;
    } else {
        FindFeatureCell *cell = [FindFeatureCell loadCode:tableView];
        return cell;
    }
}


#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = section == 0 ? kColor_BG : [UIColor whiteColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? countcoordinatesX(10) : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(90);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.section == 0) {
        BillController *vc = [[BillController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}


#pragma mark - get
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - TabbarHeight) style:UITableViewStylePlain];
        [_table setDelegate:self];
        [_table setDataSource:self];
        [_table setSeparatorColor:[UIColor clearColor]];
        [_table lineAll];
        [_table lineHide];
        [self.view addSubview:_table];
    }
    return _table;
}


#pragma mark - 系统
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.table reloadData];
}



@end
