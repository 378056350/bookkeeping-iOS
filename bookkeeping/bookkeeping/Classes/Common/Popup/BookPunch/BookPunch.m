/**
 * 打卡
 * @author 郑业强 2018-12-20 创建文件
 */

#import "BookPunch.h"
#import <SDWebImage/UIImage+GIF.h>

#pragma mark - 声明
@interface BookPunch()

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *successLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *punchConstraintH;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareConstraintH;

@end


#pragma mark - 实现
@implementation BookPunch


- (void)initUI {
    [self.layer setCornerRadius:5];
    [self.layer setMasksToBounds:YES];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"signin_gif@2x" ofType:@"gif"]];
    [self.back setBackgroundColor:kColor_Main_Color];
    [self.icon setImage:[UIImage sd_animatedGIFWithData:data]];
    [self.successLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.successLab setTextColor:kColor_Text_Gary];
    [self createLabel:self];
    [self.shareBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Red_Color] forState:UIControlStateNormal];
    [self.shareBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Red_Dark_Color] forState:UIControlStateHighlighted];
    [self.shareBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
    [self.shareBtn setTitleColor:kColor_White forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:kColor_White forState:UIControlStateHighlighted];
    [self.shareBtn.layer setCornerRadius:3];
    [self.shareBtn.layer setMasksToBounds:YES];
    
    [self.punchConstraintH setConstant:countcoordinatesX(80)];
    [self.shareConstraintH setConstant:countcoordinatesX(35)];
}

- (void)createLabel:(UIView *)view {
    for (UIView *subview in view.subviews) {
        [self createLabel:subview];
        if ([subview isKindOfClass:[UILabel class]]) {
            if (subview.tag == 10) {
                UILabel *lab = (UILabel *)subview;
                lab.font = [UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight];
                lab.textColor = kColor_Text_Black;
            }
            else if (subview.tag == 11) {
                UILabel *lab = (UILabel *)subview;
                lab.font = [UIFont systemFontOfSize:AdjustFont(8) weight:UIFontWeightLight];
                lab.textColor = kColor_Text_Gary;
            }
        }
    }
}


#pragma mark - 关闭
// 关闭
- (IBAction)closeBtnClick:(UIButton *)sender {
    if (self.popup.click) {
        self.popup.click(@(-1), self.popup);
    }
}
// 炫耀
- (IBAction)shareBtnClick:(UIButton *)sender {
    if (self.popup.click) {
        self.popup.click(@(1), self.popup);
    }
}


#pragma mark - KKPopupDelegate
// 创建Rect
+ (CGRect)createContentFrame {
    CGFloat left = SCREEN_WIDTH / 5.f;
    CGFloat width = SCREEN_WIDTH - left * 2;
    CGFloat height = width / 450.f * 540.f;
    return CGRectMake(left, 0, width, height);
}
// 创建样式
+ (KKPopupStatus)createStatus {
    return KKPopupStatusCenter;
}



@end
