/**
 * item
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ChartDateCell.h"

#pragma mark - 声明
@interface ChartDateCell()

@property (weak  , nonatomic) IBOutlet UILabel *lab;

@end


#pragma mark - 实现
@implementation ChartDateCell


- (void)initUI {
    self.lab.font = LAB_FONT;
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
- (void)setModel:(ChartSubModel *)model {
    _model = model;
    _lab.text = model.detail;
}

@end
