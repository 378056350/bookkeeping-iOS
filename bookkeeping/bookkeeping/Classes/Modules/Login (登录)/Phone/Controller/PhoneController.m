/**
 * 手机登录
 * @author 郑业强 2018-12-23 创建文件
 */

#import "PhoneController.h"
#import "RE1Controller.h"
#import "LOGIN_NOTIFICATION.h"


#pragma mark - 声明
@interface PhoneController() {
    NSInteger index;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *findBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *otherLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneConstraintR;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qqLogConstraintB;

@end


#pragma mark - 实现
@implementation PhoneController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:YES];
    [self.view setBackgroundColor:kColor_BG];
    [self.nameLab1 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab1 setTextColor:kColor_Text_Black];
    [self.nameLab2 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab2 setTextColor:kColor_Text_Black];
    [self.phoneField setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.phoneField setTextColor:kColor_Text_Black];
    [self.passField setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.passField setTextColor:kColor_Text_Black];
    [self buttonCanTap:false btn:self.loginBtn];
    [self buttonCanTap:true btn:self.qqLoginBtn];
    [self.findBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.line setBackgroundColor:kColor_Line_Color];
    [self.otherLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.otherLab setTextColor:kColor_Text_Gary];
    [self.otherLab setBackgroundColor:kColor_BG];
    [self.phoneField addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.passField addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    
    [self.phoneConstraintL setConstant:countcoordinatesX(15)];
    [self.phoneConstraintR setConstant:countcoordinatesX(15)];
    [self.phoneConstraintH setConstant:countcoordinatesX(45)];
    [self.loginConstraintH setConstant:countcoordinatesX(45)];
    [self.qqLogConstraintB setConstant:countcoordinatesX(80) + SafeAreaBottomHeight];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


// 按钮是否可以点击
- (void)buttonCanTap:(BOOL)tap btn:(UIButton *)btn {
    if (tap == true) {
        [btn setUserInteractionEnabled:YES];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [btn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [btn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
    } else {
        [btn setUserInteractionEnabled:NO];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [btn setTitleColor:kColor_Text_Gary forState:UIControlStateNormal];
        [btn setTitleColor:kColor_Text_Gary forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateHighlighted];
    }
    [btn.layer setCornerRadius:3];
    [btn.layer setMasksToBounds:YES];
}


#pragma mark - 请求
// 登录
- (void)getLoginRequest {
    NSString *account = [self.phoneField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           account, @"account",
                           self.passField.text, @"password", nil];
    [self showProgressHUD];
    [self.view endEditing:true];
    [AFNManager POST:PhoneLoginRequest params:param complete:^(APPResult *result) {
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            [UserInfo saveUserInfo:result.data];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOPGIN_LOGIN_COMPLETE object:nil];
        } else {
            [self showTextHUD:result.message delay:1.5f];
        }
    }];
}


#pragma mark - 点击
// 登录
- (IBAction)loginClick:(UIButton *)sender {
    [self getLoginRequest];
}
// 关闭
- (IBAction)closeBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// 注册
- (IBAction)registerBtnClick:(UIButton *)sender {
    RE1Controller *vc = [[RE1Controller alloc] init];
    [vc setIndex:0];
    [self.navigationController pushViewController:vc animated:YES];
}
// 找回密码
- (IBAction)forgetBtnClick:(UIButton *)sender {
    RE1Controller *vc = [[RE1Controller alloc] init];
    [vc setIndex:1];
    [self.navigationController pushViewController:vc animated:YES];
}



// 文本编辑
- (void)textFieldDidEditing:(UITextField *)textField {
    if (textField == self.phoneField) {
        if (textField.text.length > index) {
            // 输入
            if (textField.text.length == 4 || textField.text.length == 9 ) {
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@"-" atIndex:(textField.text.length-1)];
                textField.text = str;
            }
            // 输入完成
            if (textField.text.length >= 13) {
                textField.text = [textField.text substringToIndex:13];
            }
            index = textField.text.length;
        }
        // 删除
        else if (textField.text.length < index) {
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            index = textField.text.length;
        }
    }
    
    if (self.phoneField.text.length == 13 && self.passField.text.length != 0) {
        [self buttonCanTap:true btn:self.loginBtn];
    } else {
        [self buttonCanTap:false btn:self.loginBtn];
    }
    
}



@end
