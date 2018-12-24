/**
 * 注册
 * @author 郑业强 2018-12-22 创建文件
 */

#import "RE2Controller.h"
#import "RE3Controller.h"

#pragma mark - 声明
@interface RE2Controller()

@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic, strong) CountDown *countDown;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneConstraintR;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneConstraintH;

@end


#pragma mark - 实现
@implementation RE2Controller


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:_index == 0 ? @"注册" : @"找回密码"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self.view setBackgroundColor:kColor_BG];
    
    [self.nameLab1 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab1 setTextColor:kColor_Text_Black];
    [self.nameLab2 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab2 setTextColor:kColor_Text_Black];
    [self.phoneField setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.phoneField setTextColor:kColor_Text_Black];
    [self.codeField setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.codeField setTextColor:kColor_Text_Black];
    [self.codeField addTarget:self action:@selector(codeValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.codeBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.nextBtn.layer setCornerRadius:3];
    [self.nextBtn.layer setMasksToBounds:YES];
    [self buttonCanTap:false];
    [self.phoneField setText:self.phone];
    
    [self.phoneConstraintL setConstant:countcoordinatesX(15)];
    [self.phoneConstraintR setConstant:countcoordinatesX(15)];
    [self.phoneConstraintH setConstant:countcoordinatesX(45)];
}


#pragma mark - 请求
- (void)getCodeRequest {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"", @"", nil];
    @weakify(self)
    [AFNManager POST:CreateCoderequest params:param complete:^(APPResult *result) {
        if (result.status == ServiceCodeSuccess) {
            
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}



#pragma mark - 点击
// 获取验证码
- (IBAction)codeBtnClick:(UIButton *)sender {
    [self.countDown countDownWithStratTimeStamp:0 finishTimeStamp:3 * 1000 completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (second != 0 || minute != 0) {
            NSString *str = [NSString stringWithFormat:@"%02lds重新获取", second];
            [self.codeBtn setTitle:str forState:UIControlStateNormal];
            [self.codeBtn setTitle:str forState:UIControlStateHighlighted];
            [self.codeBtn setUserInteractionEnabled:NO];
        } else {
            [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            [self.codeBtn setTitle:@"重新获取" forState:UIControlStateHighlighted];
            [self.codeBtn setUserInteractionEnabled:YES];
        }
    }];
}
// 下一步
- (IBAction)nextBtnClick:(UIButton *)sender {
    RE3Controller *vc = [[RE3Controller alloc] init];
    vc.index = _index;
    [self.navigationController pushViewController:vc animated:YES];
}
// 点背景
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
// 按钮是否可以点击
- (void)buttonCanTap:(BOOL)tap {
    if (tap == true) {
        [self.nextBtn setUserInteractionEnabled:YES];
        [self.nextBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [self.nextBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [self.nextBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
        [self.nextBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
        [self.nextBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
    } else {
        [self.nextBtn setUserInteractionEnabled:NO];
        [self.nextBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [self.nextBtn setTitleColor:kColor_Text_Gary forState:UIControlStateNormal];
        [self.nextBtn setTitleColor:kColor_Text_Gary forState:UIControlStateHighlighted];
        [self.nextBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateNormal];
        [self.nextBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateHighlighted];
    }
}


// 验证码编辑
- (void)codeValueChange:(UITextField *)code {
    if (code.text.length > 6) {
        code.text = [code.text substringToIndex:6];
    }
    [self buttonCanTap:code.text.length == 6];
}


#pragma mark - get
- (CountDown *)countDown {
    if (!_countDown) {
        _countDown = [[CountDown alloc] init];
    }
    return _countDown;
}


@end
