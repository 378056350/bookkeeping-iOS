/**
 * 徽章
 * @author 郑业强 2018-12-21 创建文件
 */

#import "KKBadge.h"


#pragma mark - 声明
@interface KKBadge()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end


#pragma mark - 实现
@implementation KKBadge


- (void)initUI {
    [self.bgView.layer setCornerRadius:10];
    [self.bgView.layer setMasksToBounds:YES];
    [self.shareBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Red_Color] forState:UIControlStateNormal];
    [self.shareBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Red_Dark_Color] forState:UIControlStateHighlighted];
    [self.shareBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.shareBtn.layer setCornerRadius:5];
    [self.shareBtn.layer setMasksToBounds:YES];
    
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Gary];
    [self.detailLab setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.detailLab setTextColor:kColor_Text_Gary];
    
}


#pragma mark - 关闭
// 关闭
- (IBAction)closeBtnClick:(UIButton *)sender {
    if (self.popup.click) {
        self.popup.click(@(-1), self.popup);
    }
}
// 分享
- (IBAction)shareBtnClick:(UIButton *)sender {
    if (self.popup.click) {
        self.popup.click(@(1), self.popup);
    }
}


#pragma mark - set
// 数据
- (void)setModel:(BadgeModel *)model {
    _model = model;
    [_nameLab setText:model.detail];
    [_detailLab setText:@"只要路是对的, 就不怕路远"];
    if (model.has_own == true) {
        [_nameLab setTextColor:kColor_Text_Black];
        [_detailLab setTextColor:kColor_Text_Black];
        [_bottomView setBackgroundColor:kColor_Main_Color];
        [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.icon_big_s)]];
    } else {
        [_nameLab setTextColor:kColor_Text_Gary];
        [_detailLab setTextColor:kColor_Text_Gary];
        [_bottomView setBackgroundColor:kColor_BG];
        [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.icon_big_n)]];
    }
}


#pragma mark - KKPopupDelegate
// 创建Rect
+ (CGRect)createContentFrame {
    CGFloat left = SCREEN_WIDTH / 6.f;
    CGFloat width = SCREEN_WIDTH - left * 2;
    CGFloat height = 0;
    height += 20;
    height += width / 3.f * 2;
    height += 90;
    height += 25;
    height += 40;
    
    return CGRectMake(left, 0, width, height);
}
// 创建样式
+ (KKPopupStatus)createStatus {
    return KKPopupStatusCenter;
}


@end
