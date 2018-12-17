/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BadgeCollectionCell.h"

#pragma mark - 声明
@interface BadgeCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end


#pragma mark - 实现
@implementation BadgeCollectionCell


- (void)initUI {
    self.lab.font = [UIFont systemFontOfSize:AdjustFont(14)];
    self.lab.textColor = kColor_Text_Gary;
}


#pragma mark - set
- (void)setChoose:(BOOL)choose {
    _choose = choose;
    if (choose == true) {
        _icon.image = [UIImage imageNamed:@"1_s"];
    } else {
        _icon.image = [UIImage imageNamed:@"1"];
    }
}


@end
