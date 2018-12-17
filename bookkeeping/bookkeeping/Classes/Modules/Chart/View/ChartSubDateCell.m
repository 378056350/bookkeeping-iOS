/**
 * item
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ChartSubDateCell.h"

#pragma mark - 声明
@interface ChartSubDateCell()

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end


#pragma mark - 实现
@implementation ChartSubDateCell


- (void)initUI {
    self.lab.font = [UIFont systemFontOfSize:AdjustFont(14)];
    self.lab.textColor = kColor_Text_Black;
}


@end
