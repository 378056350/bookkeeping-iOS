/**
 * 个人信息
 * @author 郑业强 2018-12-22 创建文件
 */

#import "InfoController.h"
#import "InfoTableView.h"
#import "InfoModel.h"
#import "CPAController.h"
#import "INFO_EVENT_MANAGER.h"


#pragma mark - 声明
@interface InfoController()

@property (nonatomic, strong) InfoTableView *table;
@property (nonatomic, strong) InfoModel *model;
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
    [self createInfoRequest];
}


#pragma mark - 请求
// 获取个人信息
- (void)createInfoRequest {
    UserModel *model = [UserInfo loadUserInfo];
    NSString *key = model.openid ? @"openid" : @"account";
    NSString *value = model.openid ? model.openid : model.account;
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:value, key, nil];
    @weakify(self)
    [self createRequest:InfoRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        if (result.status == ServiceCodeSuccess) {
            [self setModel:[InfoModel mj_objectWithKeyValues:result.data]];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}
// 绑定第三方账号
- (void)bindThirdRequest {
    // QQ授权
    @weakify(self)
    [self umQQUserInfo:^(KKSocialUserInfoResponse *resp) {
        @strongify(self)
        UserModel *model = [UserInfo loadUserInfo];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               model.account, @"account",
                               resp.openid, @"openid",
                               resp.name, @"nickname",
                               [resp.gender isEqualToString:@"男"] ? @"1" : @"0", @"sex", nil];
        [AFNManager POST:BindThirdRequest params:param complete:^(APPResult *result) {
            [self hideHUD];
            if (result.status == ServiceCodeSuccess) {
                [self showTextHUD:result.message delay:1.f];
            } else {
                [self showTextHUD:result.message delay:1.f];
            }
        }];
    }];
}


#pragma mark - set
- (void)setModel:(InfoModel *)model {
    _model = model;
    _table.model = model;
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
// 点击cell
- (void)cellClick:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
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
    } else {
        CPAController *vc = [[CPAController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}
// 点击尾视图
- (void)footerClick:(id)data {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles: nil];
    [sheet showInView:self.view];
    [[sheet rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSInteger index = [number integerValue];
        if (index == 0) {
            [UserInfo clearUserInfo];
            [self.navigationController popViewControllerAnimated:true];
        } else if (index == 1) {
            NSLog(@"123");
        }
    }];
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
                           INFO_FOOTER_CLICK: [self createInvocationWithSelector:@selector(footerClick:)],
                           };
    }
    return _eventStrategy;
}


@end
