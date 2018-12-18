/**
 * 列表Cell
 * @author 郑业强 2018-12-18 创建文件
 */

#import "HomeListSubCell.h"

#pragma mark - 声明
@interface HomeListSubCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailConstraintR;

@end


#pragma mark - 实现
@implementation HomeListSubCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.icon setBackgroundColor:kColor_Main_Color];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.detailLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.detailLab setTextColor:kColor_Text_Black];
    
    [self.iconConstraintL setConstant:countcoordinatesX(15)];
    [self.detailConstraintR setConstant:countcoordinatesX(15)];
}


@end
