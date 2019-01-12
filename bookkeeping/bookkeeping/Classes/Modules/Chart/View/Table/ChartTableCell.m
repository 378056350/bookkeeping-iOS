/**
 * 图表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "ChartTableCell.h"

#define ICON_W countcoordinatesX(25)
#define LINE_L countcoordinatesX(10)

#pragma mark - 声明
@interface ChartTableCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraintW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailConstraintR;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintW;

@end


#pragma mark - 实现
@implementation ChartTableCell

- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.detailLab setFont:[UIFont fontWithName:@"Helvetica Neue" size:AdjustFont(12)]];
    [self.detailLab setTextColor:kColor_Text_Black];
    [self.line setImage:[UIColor createImageWithColor:kColor_Main_Color]];
    
    [self.iconConstraintL setConstant:OUT_PADDING];
    [self.iconConstraintW setConstant:ICON_W];
    [self.lineConstraintL setConstant:LINE_L];
    [self.detailConstraintR setConstant:OUT_PADDING];
    [self.lineConstraintH setConstant:countcoordinatesX(5)];
    [self.line.layer setCornerRadius:self.lineConstraintH.constant / 2];
    [self.line.layer setMasksToBounds:true];
}


#pragma mark - set
- (void)setModel:(BKModel *)model {
    _model = model;
    [_icon setImage:[UIImage imageNamed:model.cmodel.icon_l]];
    [_nameLab setText:model.cmodel.name];
    [_detailLab setText:[@(model.price) description]];
    
    CGFloat width = SCREEN_WIDTH - OUT_PADDING * 2 - ICON_W - LINE_L;
    width = width / _maxPrice * model.price;
    [self.lineConstraintW setConstant:width];
}



@end
