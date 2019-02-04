/**
 * 图片
 * @author 郑业强 2019-02-04
 */

#import "CCIconCell.h"
#import "CCCellConfig.h"

#pragma mark - 声明
@interface CCIconCell()

@property (nonatomic, strong) NSMutableArray<UIImageView *> *images;

@end


#pragma mark - 实现
@implementation CCIconCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self images];
    [self updateFrame];
}
- (void)updateFrame {
    if (self.model.images.count == 1) {
        self.images[0].frame = CGRectMake(CELL_NAME_L, 0, CELL_IMAGE_W * 1.5, CELL_IMAGE_W * 1.5);
    } else {
        for (int i=0; i<_model.images.count; i++) {
            NSInteger row = i / 3;
            NSInteger col = i % 3;
            CGFloat left = CELL_NAME_L + col * (CELL_IMAGE_W + CELL_IN_PADDING_W);
            CGFloat top = row * (CELL_IMAGE_H + CELL_IN_PADDING_H);
            self.images[i].frame = CGRectMake(left, top, CELL_IMAGE_W, CELL_IMAGE_H);
        }
    }
}
+ (CGFloat)getCellHeight:(CCModel *)model {
    if (model.images.count == 0) {
        return 0;
    } else if (model.images.count == 1) {
        return CELL_IMAGE_W * 1.5 + CELL_IN_PADDING_H;
    } else {
        CGFloat row = model.images.count / 3 + 1;
        CGFloat height = row * CELL_IMAGE_H + (row - 1) * CELL_IN_PADDING_H + CELL_IN_PADDING_H;
        return height;
    }
}


#pragma mark - set
- (void)setModel:(CCModel *)model {
    _model = model;
    for (int i=0; i<model.images.count; i++) {
        UIImageView *image = self.images[i];
        [image setHidden:false];
        [image sd_setImageWithURL:[NSURL URLWithString:model.images[i]]];
    }
    [self updateFrame];
}


#pragma mark - get
- (NSMutableArray<UIImageView *> *)images {
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i=0; i<9; i++) {
            UIImageView *image = [[UIImageView alloc] initWithFrame:({
                NSInteger row = i / 3;
                NSInteger col = i % 3;
                CGFloat left = CELL_NAME_L + col * (CELL_IMAGE_W + CELL_IN_PADDING_W);
                CGFloat top = row * (CELL_IMAGE_H + CELL_IN_PADDING_H);
                CGRectMake(left, top, CELL_IMAGE_W, CELL_IMAGE_H);
            })];
            [image setHidden:true];
            [image setClipsToBounds:true];
            [image setBackgroundColor:[UIColor redColor]];
            [image setContentMode:UIViewContentModeScaleAspectFill];
            [self.contentView addSubview:image];
            [_images addObject:image];
        }
    }
    return _images;
}



@end
