/**
 * 图表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "ChartTableCell.h"

#pragma mark - 声明
@interface ChartTableCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end


#pragma mark - 实现
@implementation ChartTableCell

- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.detailLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.detailLab setTextColor:kColor_Text_Black];
}

@end
