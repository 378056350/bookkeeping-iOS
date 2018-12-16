/**
 * 列表Cell
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BookCollectionCell.h"

#pragma mark - 声明
@interface BookCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end


#pragma mark - 实现
@implementation BookCollectionCell


- (void)initUI {
    self.lab.font = [UIFont systemFontOfSize:AdjustFont(12)];
    self.lab.textColor = kColor_Text_Gary;
}
- (void)setChoose:(BOOL)choose {
    _choose = choose;
    // 选中
    if (choose == YES) {
        self.icon.image = [UIImage imageNamed:@"cc_entertainmente_climbing_s"];
    }
    // 未选中
    else {
        self.icon.image = [UIImage imageNamed:@"cc_entertainmente_climbing"];
    }
}


@end
