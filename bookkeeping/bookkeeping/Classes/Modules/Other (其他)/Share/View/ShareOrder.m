/**
 * 分享
 * @author 郑业强 2018-12-20 创建文件
 */

#import "ShareOrder.h"

#pragma mark - 声明
@interface ShareOrder()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *cateLab;
@property (weak, nonatomic) IBOutlet UILabel *cateDescLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIImageView *qrIcon;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end


#pragma mark - 实现
@implementation ShareOrder

- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.cateLab setFont:[UIFont systemFontOfSize:AdjustFont(20) weight:UIFontWeightLight]];
    [self.cateLab setTextColor:kColor_Text_Black];
    [self.cateDescLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.cateDescLab setTextColor:kColor_Text_Black];
    [self.qrIcon setBackgroundColor:kColor_Red_Color];
    [self.moneyLab setAttributedText:[NSAttributedString createMath:@"99.00" integer:[UIFont systemFontOfSize:AdjustFont(22) weight:UIFontWeightLight] decimal:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight] color:kColor_Red_Color]];
}

@end
