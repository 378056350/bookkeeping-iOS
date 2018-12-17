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
    self.lab.font = [UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight];
}


#pragma mark - set
- (void)setChoose:(BOOL)choose {
    _choose = choose;
    if (choose == YES) {
        _lab.textColor = kColor_Text_Black;
    } else {
        _lab.textColor = kColor_Text_Gary;
    }
}



@end
