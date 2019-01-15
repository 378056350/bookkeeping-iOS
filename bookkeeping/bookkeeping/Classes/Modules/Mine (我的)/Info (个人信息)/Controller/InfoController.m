/**
 * 个人信息
 * @author 郑业强 2018-12-22 创建文件
 */

#import "InfoController.h"
#import "InfoTableView.h"
#import "CPAController.h"
#import "RE1Controller.h"
#import "INFO_EVENT_MANAGER.h"
#import "LOGIN_NOTIFICATION.h"


#pragma mark - 声明
@interface InfoController()

@property (nonatomic, strong) InfoTableView *table;
@property (nonatomic, strong) UserModel *model;
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
    [self setModel:[UserInfo loadUserInfo]];
}


#pragma mark - 请求
// 更换头像
- (void)changeIconRequest:(UIImage *)image {
    @weakify(self)
    UserModel *model = [UserInfo loadUserInfo];
    NSMutableDictionary *param = ({
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        if (model.account) {
            [param setObject:model.account forKey:@"account"];
        }
        if (model.openid) {
            [param setObject:model.openid forKey:@"openid"];
        }
        param;
    });
    [self.afn_request setAfn_useCache:false];
    [self showProgressHUD:@"修改中"];
    [AFNManager POST:ChangeIconRequest params:param andImages:@[image] progress:nil complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            // 更新数据
            UserModel *model = [UserInfo loadUserInfo];
            [model setIcon:result.data];
            [UserInfo saveUserModel:model];
            [self setModel:model];
            // 刷新
            [self.table reloadData];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}
// 更改昵称
- (void)changeNickRequest:(NSString *)nickName {
    @weakify(self)
    UserModel *model = [UserInfo loadUserInfo];
    NSMutableDictionary *param = ({
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:nickName forKey:@"name"];
        if (model.account) {
            [param setObject:model.account forKey:@"account"];
        }
        if (model.openid) {
            [param setObject:model.openid forKey:@"openid"];
        }
        param;
    });
    [self.afn_request setAfn_useCache:false];
    [self showProgressHUD:@"修改中"];
    [AFNManager POST:NicknameRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            // 更新数据
            UserModel *model = [UserInfo loadUserInfo];
            [model setNickname:nickName];
            [UserInfo saveUserModel:model];
            [self setModel:model];
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
        [AFNManager POST:BindThirdRequest params:param andImages:@[resp.icon] progress:nil complete:^(APPResult *result) {
            [self hideHUD];
            if (result.status == ServiceCodeSuccess) {
                UserModel *model = [UserInfo loadUserInfo];
                [model setOpenid:resp.openid];
                [UserInfo saveUserModel:model];
                [self setModel:model];
            } else {
                [self showTextHUD:result.message delay:1.f];
            }
        }];
            
    }];
}
// 更改性别
- (void)changeSexRequest:(NSInteger)sex {
    @weakify(self)
    UserModel *model = [UserInfo loadUserInfo];
    NSMutableDictionary *param = ({
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:@(sex) forKey:@"sex"];
        if (model.account) {
            [param setObject:model.account forKey:@"account"];
        }
        if (model.openid) {
            [param setObject:model.openid forKey:@"openid"];
        }
        param;
    });
    [self.afn_request setAfn_useCache:false];
    [self showProgressHUD:@"修改中"];
    [AFNManager POST:ChangeSexRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            // 更新数据
            UserModel *model = [UserInfo loadUserInfo];
            [model setSex:sex];
            [UserInfo saveUserModel:model];
            [self setModel:model];
            // 刷新
            [self.table reloadData];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}


#pragma mark - set
- (void)setModel:(UserModel *)model {
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
            UserModel *model = [UserInfo loadUserInfo];
            if (!model.account) {
                RE1Controller *vc = [[RE1Controller alloc] init];
                vc.index = 2;
                vc.openid = model.openid;
                vc.complete = ^{
                    [self.navigationController popToViewController:self animated:true];
                    UserModel *model = [UserInfo loadUserInfo];
                    [model setAccount:[UserInfo loadUserInfo].account];
                    [UserInfo saveUserModel:model];
                    [self setModel:model];
                };
                [self.navigationController pushViewController:vc animated:true];
            }
        }
        // 绑定QQ
        else if (indexPath.row == 5) {
            UserModel *model = [UserInfo loadUserInfo];
            if (!model.openid) {
                [self bindThirdRequest];
            }
        }
    } else {
        CPAController *vc = [[CPAController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}
// 退出登录
- (void)footerClick:(id)data {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles: nil];
    [sheet showInView:self.view];
    [[sheet rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSInteger index = [number integerValue];
        if (index == 0) {
            [UserInfo clearUserInfo];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_BOOK];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_BOOK_SYNCED];
            [self.navigationController popViewControllerAnimated:true];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOPGIN_LOGOUT_COMPLETE object:nil];
        }
    }];
}
// 拍照
- (void)takePhoto {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [sheet showInView:self.view];
    [[sheet rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSInteger index = [number integerValue];
        // 拍照
        if (index == 0) {
            @weakify(self)
            ZLCustomCamera *camera = [[ZLCustomCamera alloc] init];
            [camera setAllowTakePhoto:true];
            [camera setAllowRecordVideo:false];
            [camera setSessionPreset:ZLCaptureSessionPreset640x480];
            [camera setDoneBlock:^(UIImage *image, NSURL *videoUrl) {
                @strongify(self)
                [self changeIconRequest:image];
            }];
        }
        // 从相册选择
        else if (index == 1) {
            @weakify(self)
            ZLPhotoActionSheet *actionSheet = [ZLPhotoActionSheet getNormalDefault];
            [actionSheet setSender:self];
            [actionSheet showPhotoLibrary];
            [actionSheet setSelectImageBlock:^(NSArray<UIImage *> *images, NSArray<PHAsset *> *assets, BOOL isOriginal) {
                @strongify(self)
                [self changeIconRequest:images[0]];
            }];
        }
    }];
}
// 性别
- (void)takeSex {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
    [sheet showInView:self.view];
    [[sheet rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSInteger index = [number integerValue];
        if (index == 0) {
            UserModel *model = [UserInfo loadUserInfo];
            if (model.sex != true) {
                [self changeSexRequest:1];
            }
        } else if (index == 1) {
            UserModel *model = [UserInfo loadUserInfo];
            if (model.sex != false) {
                [self changeSexRequest:0];
            }
        }
    }];
}
// 昵称
- (void)takeNickname {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"昵称" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *txtName = [alert textFieldAtIndex:0];
    [txtName setPlaceholder:@"请输入2-8位昵称"];
    [txtName addTarget:self action:@selector(txtValueChange:) forControlEvents:UIControlEventEditingChanged];
    [alert show];
    [[alert rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSInteger index = [number integerValue];
        // 确定
        if (index == 1) {
            if (txtName.text.length == 0) {
                [self showTextHUD:@"昵称不能为空" delay:1.f];
                return;
            }
            [self changeNickRequest:txtName.text];
        }
    }];
}

- (void)txtValueChange:(UITextField *)textField {
    if (textField.text.length > 8) {
        textField.text = [textField.text substringToIndex:8];
    }
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
