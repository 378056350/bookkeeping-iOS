/**
 * 登录
 * @author 郑业强 2018-12-17 创建文件
 */


#import "LoginController.h"
#import "RE1Controller.h"
#import "PhoneController.h"


#pragma mark - 声明
@interface LoginController()

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *nameIcn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreBtnConstraintB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxConstraintH;

@end


#pragma mark - 实现
@implementation LoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:YES];
    
    [self.wxLoginBtn.layer setCornerRadius:3];
    [self.wxLoginBtn.layer setMasksToBounds:YES];
    [self.wxLoginBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.wxLoginBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.wxLoginBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
    [self.wxLoginBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
    [self.wxLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.moreBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
    [self.moreBtn setTitleColor:kColor_Text_Gary forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:kColor_Text_Gary forState:UIControlStateHighlighted];
    
    
    [self.moreBtnConstraintB setConstant:countcoordinatesX(20) + SafeAreaBottomHeight];
    [self.wxConstraintH setConstant:countcoordinatesX(45)];
}


#pragma mark - 请求
// QQ登录
- (void)getQQLoginRequest:(UMSocialUserInfoResponse *)resp {
    @weakify(self)
    NSURL *url = [NSURL URLWithString:resp.iconurl];
    [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        @strongify(self)
        if (error) {
            [self showTextHUD:@"图片获取失败" delay:1.5f];
            return;
        }
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               resp.openid, @"openid",
                               resp.name, @"nickname",
                               [resp.gender isEqualToString:@"男"] ? @(1) : @(0), @"sex", nil];
        NSArray *images = @[image];
        [self showProgressHUD];
        @weakify(self)
        [AFNManager POST:QQLoginRequest params:param andImages:images progress:nil complete:^(APPResult *result) {
            @strongify(self)
            [self hideHUD];
            if (result.status == ServiceCodeSuccess) {
                [self showTextHUD:result.message delay:1.5f];
            } else {
                [self showTextHUD:result.message delay:1.5f];
            }
        }];
    }];
}


#pragma mark - 点击
// 关闭
- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
// 微信
- (IBAction)wxBtnClick:(UIButton *)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [self showTextHUD:@"登录失败" delay:1.5f];
        } else {
            UMSocialUserInfoResponse *resp = result;
            [self getQQLoginRequest:resp];
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}
// 更多登录方式
- (IBAction)moreBtnClick:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"注册", @"手机登录", nil];
    [sheet showInView:self.view];
    [[sheet rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSInteger index = [number integerValue];
        // 注册
        if (index == 0) {
            RE1Controller *vc = [[RE1Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        // 手机登录
        else if (index == 1) {
            PhoneController *vc = [[PhoneController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}


@end
