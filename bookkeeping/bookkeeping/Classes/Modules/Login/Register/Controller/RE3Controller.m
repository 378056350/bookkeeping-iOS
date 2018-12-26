/**
 * 注册
 * @author 郑业强 2018-12-22 创建文件
 */

#import "RE3Controller.h"
#import "LOGIN_NOTIFICATION.h"


#pragma mark - 声明
@interface RE3Controller()

@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UITextField *pass1Field;
@property (weak, nonatomic) IBOutlet UITextField *pass2Field;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passConstraintR;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;

@end


#pragma mark - 实现
@implementation RE3Controller


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:({
        NSString *str;
        if (_index == 0) {
            str = @"注册";
        } else if (_index == 1) {
            str = @"找回密码";
        } else if (_index == 2) {
            str = @"绑定账号";
        }
        str;
    })];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self.view setBackgroundColor:kColor_BG];
    [self.nameLab1 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab1 setTextColor:kColor_Text_Black];
    [self.nameLab2 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab2 setTextColor:kColor_Text_Black];
    [self.pass1Field setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.pass1Field setTextColor:kColor_Text_Black];
    [self.pass2Field setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.pass2Field setTextColor:kColor_Text_Black];
    [self buttonCanTap:false];
    [self.pass1Field addTarget:self action:@selector(pass1ValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pass2Field addTarget:self action:@selector(pass2ValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tipLab setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.tipLab setTextColor:kColor_Text_Gary];
    [self.registerBtn.layer setCornerRadius:3];
    [self.registerBtn.layer setMasksToBounds:true];
    
    [self.passConstraintL setConstant:countcoordinatesX(15)];
    [self.passConstraintR setConstant:countcoordinatesX(15)];
    [self.passConstraintH setConstant:countcoordinatesX(45)];
}


#pragma mark - 请求
// 注册
- (void)registerRequest {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.phone, @"account",
                           self.pass1Field.text, @"password", nil];
    [self.view endEditing:true];
    [self showProgressHUD];
    @weakify(self)
    [AFNManager POST:RegisterRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            [UserInfo saveUserInfo:result.data];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOPGIN_REGISTER_COMPLETE object:nil];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}
// 忘记密码
- (void)forgetRequest {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.phone, @"account",
                           self.pass1Field.text, @"password", nil];
    [self.view endEditing:true];
    [self showProgressHUD];
    @weakify(self)
    [AFNManager POST:ForgetPassRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            [UserInfo saveUserInfo:result.data];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOPGIN_LOGIN_COMPLETE object:nil];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}
// 绑定手机
- (void)bindPhoneRequest {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.phone, @"account",
                           self.openid, @"openid",
                           self.pass1Field.text, @"password", nil];
    [self.view endEditing:true];
    [self showProgressHUD];
    @weakify(self)
    [AFNManager POST:BindPhoneRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            UserModel *model = [UserInfo loadUserInfo];
            [model setAccount:self.phone];
            [UserInfo saveUserModel:model];
            [[NSNotificationCenter defaultCenter] postNotificationName:BIND_PHONE_COMPLETE object:nil];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}


#pragma mark - 点击
// 注册
- (IBAction)registerBtnClick:(UIButton *)sender {
    if (self.index == 0) {
        [self registerRequest];
    } else if (self.index == 1) {
        [self forgetRequest];
    } else if (self.index == 2) {
        [self bindPhoneRequest];
    }
}
// 按钮是否可以点击
- (void)buttonCanTap:(BOOL)tap {
    if (tap == true) {
        [self.registerBtn setUserInteractionEnabled:YES];
        [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [self.registerBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [self.registerBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
        [self.registerBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
        [self.registerBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
    } else {
        [self.registerBtn setUserInteractionEnabled:NO];
        [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [self.registerBtn setTitleColor:kColor_Text_Gary forState:UIControlStateNormal];
        [self.registerBtn setTitleColor:kColor_Text_Gary forState:UIControlStateHighlighted];
        [self.registerBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateNormal];
        [self.registerBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateHighlighted];
    }
}


- (void)pass1ValueChange:(UITextField *)pass {
    if (pass.text.length > 15) {
        pass.text = [pass.text substringToIndex:14];
    }
    
    if ([_pass1Field.text isEqualToString:_pass2Field.text] && _pass1Field.text.length != 0) {
        [self buttonCanTap:true];
    } else {
        [self buttonCanTap:false];
    }
}
- (void)pass2ValueChange:(UITextField *)pass {
    if (pass.text.length > 15) {
        pass.text = [pass.text substringToIndex:14];
    }
    
    if ([_pass1Field.text isEqualToString:_pass2Field.text] && _pass1Field.text.length != 0) {
        [self buttonCanTap:true];
    } else {
        [self buttonCanTap:false];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
