/**
 * 截图
 * @author 郑业强 2018-12-20 创建文件
 */

#import "ShareShot.h"

#pragma mark - 声明
@interface ShareShot()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab1;
@property (weak, nonatomic) IBOutlet UILabel *tipLab2;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *tipBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyConstraintH;

@end


#pragma mark - 实现
@implementation ShareShot


- (void)initUI {
    [self.titleLab setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.titleLab setTextColor:kColor_Text_Black];
    [self.icon.layer setCornerRadius:self.icon.height / 2];
    [self.icon.layer setBorderWidth:1.f / [UIScreen mainScreen].scale];
    [self.icon.layer setBorderColor:kColor_BG.CGColor];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.tipLab1 setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.tipLab1 setTextColor:kColor_Text_Black];
    [self.tipLab2 setFont:[UIFont systemFontOfSize:AdjustFont(6) weight:UIFontWeightLight]];
    [self.tipLab2 setTextColor:kColor_Text_Black];
    [self.bottomView setBackgroundColor:kColor_Main_Color];
    [self createLabFont:self];
    [self.tipBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.tipBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [self.bottomConstraintH setConstant:countcoordinatesX(70)];
    [self.moneyConstraintH setConstant:-countcoordinatesX(30)];
}


- (void)createLabFont:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)subview;
            if (lab.tag == 10) {
                lab.font = [UIFont systemFontOfSize:AdjustFont(14)];
                lab.textColor = kColor_Text_Black;
            } else if (lab.tag == 11) {
                lab.font = [UIFont systemFontOfSize:AdjustFont(8) weight:UIFontWeightThin];
                lab.textColor = kColor_Text_Black;
            }
        } else {
            [self createLabFont:subview];
        }
    }
}


@end
