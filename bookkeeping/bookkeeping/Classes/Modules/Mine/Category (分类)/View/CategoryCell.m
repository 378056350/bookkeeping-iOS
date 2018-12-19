/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "CategoryCell.h"
#import "CATEGORY_EVENT.h"


#pragma mark - 声明
@interface CategoryCell()

@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *mentBtn;
@property (nonatomic, strong) UILongPressGestureRecognizer *longG;

@end


#pragma mark - 实现
@implementation CategoryCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self longG];
}
- (UILongPressGestureRecognizer *)longG {
    if (!_longG) {
        _longG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self.contentView addGestureRecognizer:_longG];
    }
    return _longG;
}

- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)longG {
    [self routerEventWithName:CATEGORY_LONG_GESTURE data:longG];
}


@end
