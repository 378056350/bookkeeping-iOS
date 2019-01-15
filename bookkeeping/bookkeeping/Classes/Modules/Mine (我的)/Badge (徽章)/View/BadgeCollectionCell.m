/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BadgeCollectionCell.h"

#pragma mark - 声明
@interface BadgeCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end


#pragma mark - 实现
@implementation BadgeCollectionCell


- (void)initUI {
    self.lab.font = [UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightThin];
    self.lab.textColor = kColor_Text_Gary;
}


#pragma mark - set
- (void)setModel:(BadgeModel *)model {
    _model = model;
    if (model.has_own == true) {
        [_lab setText:model.name];
        [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.icon_s)]];
    } else {
        [_lab setText:model.name];
        [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.icon_n)]];
    }
}


@end
