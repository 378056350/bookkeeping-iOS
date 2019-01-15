/**
 * 图表头视图
 * @author 郑业强 2018-12-18 创建文件
 */

#import "ChartSectionHeader.h"

#pragma mark - 声明
@interface ChartSectionHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintL;

@end


#pragma mark - 实现
@implementation ChartSectionHeader


- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.nameConstraintL setConstant:OUT_PADDING];
}


#pragma mark - set
- (void)setNavigationIndex:(NSInteger)navigationIndex {
    _navigationIndex = navigationIndex;
    if (navigationIndex == 0) {
        [_nameLab setText:@"支出排行榜"];
    } else {
        [_nameLab setText:@"收入排行榜"];
    }
}



@end
