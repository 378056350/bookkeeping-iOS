/**
 * 图表头视图
 * @author 郑业强 2018-12-18 创建文件
 */

#import "ChartSectionHeader.h"

#pragma mark - 声明
@interface ChartSectionHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


#pragma mark - 实现
@implementation ChartSectionHeader


- (void)initUI {
    self.nameLab.font = [UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight];
    self.nameLab.textColor = kColor_Text_Black;
}


@end
