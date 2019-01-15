/**
 * 列表Cell
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BKCCollectionCell.h"

#pragma mark - 声明
@interface BKCCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end


#pragma mark - 实现
@implementation BKCCollectionCell


- (void)initUI {
    self.lab.font = [UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight];
    self.lab.textColor = kColor_Text_Gary;
}
- (void)setModel:(BKCModel *)model {
    _model = model;
    [_lab setText:model.name];
    [_icon setImage:[UIImage imageNamed:_model.icon_n]];
}
- (void)setChoose:(BOOL)choose {
    _choose = choose;
    // 选中
    if (choose == YES) {
        [_icon setImage:[UIImage imageNamed:_model.icon_s]];
    }
    // 未选中
    else {
        [_icon setImage:[UIImage imageNamed:_model.icon_n]];
    }
}


@end
