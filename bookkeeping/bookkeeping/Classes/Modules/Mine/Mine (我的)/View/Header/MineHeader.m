/**
 * 头视图
 * @author 郑业强 2018-12-16 创建文件
 */

#import "MineHeader.h"

#pragma mark - 声明
@interface MineHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


#pragma mark - 实现
@implementation MineHeader


- (void)initUI {
    self.backgroundColor = kColor_Main_Color;
    self.alpha = 0;
    self.nameLab.font = [UIFont systemFontOfSize:AdjustFont(16)];
    self.nameLab.textColor = kColor_Text_Black;
}


@end
