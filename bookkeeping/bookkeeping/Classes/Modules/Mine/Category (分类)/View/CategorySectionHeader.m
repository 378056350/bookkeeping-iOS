/**
 * 头视图
 * @author 郑业强 2018-12-19 创建文件
 */

#import "CategorySectionHeader.h"

#pragma mark - 声明
@interface CategorySectionHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


#pragma mark - 实现
@implementation CategorySectionHeader


- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
}


@end
