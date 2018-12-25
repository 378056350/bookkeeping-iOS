/**
 * 修改密码
 * @author 郑业强 2018-12-24 创建文件
 */

#import "CPAController.h"

#pragma mark - 声明
@interface CPAController()

@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UILabel *nameLab3;
@property (weak, nonatomic) IBOutlet UITextField *field1;
@property (weak, nonatomic) IBOutlet UITextField *field2;
@property (weak, nonatomic) IBOutlet UITextField *field3;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@end


#pragma mark - 实现
@implementation CPAController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"修改密码"];
    [self setJz_navigationBarHidden:false];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self.nameLab1 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab1 setTextColor:kColor_Text_Black];
    [self.nameLab2 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab2 setTextColor:kColor_Text_Black];
    [self.nameLab3 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab3 setTextColor:kColor_Text_Black];
    
    [self.field1 setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.field1 setTextColor:kColor_Text_Black];
    [self.field2 setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.field2 setTextColor:kColor_Text_Black];
    [self.field3 setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.field3 setTextColor:kColor_Text_Black];
    [self.completeBtn.layer setCornerRadius:3];
    [self.completeBtn.layer setMasksToBounds:true];
    [self buttonCanTap:false];
    
    [self.field1 addTarget:self action:@selector(fieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.field2 addTarget:self action:@selector(fieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.field3 addTarget:self action:@selector(fieldValueChange:) forControlEvents:UIControlEventEditingChanged];
}


#pragma mark - 请求
- (void)getChangeRequest {
    UserModel *model = [UserInfo loadUserInfo];
    NSDictionary *param = @{@"account": model.account,
                            @"old_pass": self.field1.text,
                            @"new_pass": self.field3.text};
    [self showProgressHUD];
    [self.view endEditing:true];
    @weakify(self)
    [AFNManager POST:ChangePassRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            [self showWindowTextHUD:result.message delay:1.f];
            [self.navigationController popViewControllerAnimated:true];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}

// 完成
- (IBAction)completeClick:(UIButton *)sender {
    [self getChangeRequest];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

// 按钮是否可以点击
- (void)buttonCanTap:(BOOL)tap {
    if (tap == true) {
        [self.completeBtn setUserInteractionEnabled:YES];
        [self.completeBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [self.completeBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [self.completeBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
        [self.completeBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
        [self.completeBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
    } else {
        [self.completeBtn setUserInteractionEnabled:NO];
        [self.completeBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [self.completeBtn setTitleColor:kColor_Text_Gary forState:UIControlStateNormal];
        [self.completeBtn setTitleColor:kColor_Text_Gary forState:UIControlStateHighlighted];
        [self.completeBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateNormal];
        [self.completeBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateHighlighted];
    }
}

- (void)fieldValueChange:(UITextField *)textField {
    if (self.field1.text.length != 0 && self.field2.text.length != 0 && self.field3.text.length != 0) {
        if ([self.field2.text isEqualToString:self.field3.text]) {
            [self buttonCanTap:true];
        } else {
            [self buttonCanTap:false];
        }
    } else {
        [self buttonCanTap:false];
    }
}



@end
