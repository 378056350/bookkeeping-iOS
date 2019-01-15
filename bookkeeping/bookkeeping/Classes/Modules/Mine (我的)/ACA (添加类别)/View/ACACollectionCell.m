/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ACACollectionCell.h"

#pragma mark - 声明
@interface ACACollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintL;

@end


#pragma mark - 实现
@implementation ACACollectionCell


- (void)initUI {
    [self.iconConstraintL setConstant:countcoordinatesX(15)];
}

#pragma mark - set
- (void)setModel:(ACAModel *)model {
    _model = model;
}
- (void)setChoose:(BOOL)choose {
    _choose = choose;
    if (choose == YES) {
        [_icon setImage:[UIImage imageNamed:_model.icon_s]];
//        [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(_model.icon_s)]];
    } else {
        [_icon setImage:[UIImage imageNamed:_model.icon_n]];
//        [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(_model.icon_n)]];
    }
}



@end
