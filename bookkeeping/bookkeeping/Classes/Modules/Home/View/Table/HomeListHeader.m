/**
 * 头视图
 * @author 郑业强 2018-12-18 创建文件
 */

#import "HomeListHeader.h"

#pragma mark - 声明
@interface HomeListHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detaileConstraintR;

@end


#pragma mark - 实现
@implementation HomeListHeader


- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.detailLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.detailLab setTextColor:kColor_Text_Black];
    [self.line setBackgroundColor:kColor_BG];
    
    [self.nameConstraintL setConstant:countcoordinatesX(15)];
    [self.detaileConstraintR setConstant:countcoordinatesX(15)];
}


@end
