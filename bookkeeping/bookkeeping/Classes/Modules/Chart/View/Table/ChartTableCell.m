/**
 * 图表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "ChartTableCell.h"

#pragma mark - 声明
@interface ChartTableCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraintH;

@end


#pragma mark - 实现
@implementation ChartTableCell

- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.detailLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.detailLab setTextColor:kColor_Text_Black];
    [self.line setBackgroundColor:kColor_Main_Color];
    
    [self.lineConstraintH setConstant:countcoordinatesX(3)];
    [self.line.layer setCornerRadius:self.lineConstraintH.constant / 2];
}

- (void)setModel:(ChartModel *)model {
    _model = model;
    [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.icon_l)]];
    [_nameLab setText:model.name];
    [_detailLab setText:[@(model.price) description]];
    
}


@end
