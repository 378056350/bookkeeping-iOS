/**
 * 个人信息
 * @author 郑业强 2018-12-22 创建文件
 */

#import "InfoController.h"
#import "InfoTableView.h"
#import "INFO_EVENT_MANAGER.h"


#pragma mark - 声明
@interface InfoController()

@property (nonatomic, strong) InfoTableView *table;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation InfoController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"个人信息"];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self setJz_navigationBarHidden:NO];
    [self.view setBackgroundColor:kColor_Line_Color];
    [self table];
}


#pragma mark - 事件
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    [self handleEventWithName:eventName data:data];
}
- (void)handleEventWithName:(NSString *)eventName data:(id)data {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    [super routerEventWithName:eventName data:data];
}
- (void)cellClick:(NSIndexPath *)indexPath {
    // 拍照
    if (indexPath.row == 0) {
        [self takePhoto];
    }
    // 昵称
    else if (indexPath.row == 2) {
        [self takeNickname];
    }
    // 性别
    else if (indexPath.row == 3) {
        [self takeSex];
    }
    // 手机号
    else if (indexPath.row == 4) {
        
    }
}

// 拍照
- (void)takePhoto {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [sheet showInView:self.view];
    [[sheet rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSLog(@"123");
    }];
}
// 昵称
- (void)takeNickname {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"昵称" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *txtName = [alert textFieldAtIndex:0];
    [txtName setPlaceholder:@"请输入2-8位昵称"];
    [alert show];
    [[alert rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        
    }];
}
// 性别
- (void)takeSex {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
    [sheet showInView:self.view];
    [[sheet rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSLog(@"123");
    }];
}


#pragma mark - get
- (InfoTableView *)table {
    if (!_table) {
        _table = [[InfoTableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight) style:UITableViewStylePlain];
        [self.view addSubview:_table];
    }
    return _table;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           INFO_CELL_CLICK: [self createInvocationWithSelector:@selector(cellClick:)],
                           
                           };
    }
    return _eventStrategy;
}


@end
