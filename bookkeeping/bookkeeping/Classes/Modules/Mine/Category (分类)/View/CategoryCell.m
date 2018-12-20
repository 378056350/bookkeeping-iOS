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
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (nonatomic, strong) UILongPressGestureRecognizer *longG;

@end


#pragma mark - 实现
@implementation CategoryCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.actionBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self longG];
    
    @weakify(self)
    MGSwipeButton *btn = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:kColor_Red_Color];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [btn setButtonWidth:countcoordinatesX(80)];
    [btn setCallback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        @strongify(self)
        [self routerEventWithName:CATEGORY_ACTION_DELETE_CLICK data:self];
        return NO;
    }];
    [self setRightButtons:@[btn]];
}


#pragma mark - 点击
// 删除
- (IBAction)actionClick:(UIButton *)sender {
    [self routerEventWithName:CATEGORY_ACTION_CLICK data:self];
}


#pragma mark - set
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (indexPath.section == 0) {
        [self.actionBtn setImage:[UIImage imageNamed:@"category_delete"] forState:UIControlStateNormal];
        [self.actionBtn setImage:[UIImage imageNamed:@"category_delete"] forState:UIControlStateHighlighted];
    } else {
        [self.actionBtn setImage:[UIImage imageNamed:@"category_add"] forState:UIControlStateNormal];
        [self.actionBtn setImage:[UIImage imageNamed:@"category_add"] forState:UIControlStateHighlighted];
    }
}


#pragma mark - 手势
- (UILongPressGestureRecognizer *)longG {
    if (!_longG) {
        _longG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self.menuBtn addGestureRecognizer:_longG];
    }
    return _longG;
}
- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)longG {
    [self routerEventWithName:CATEGORY_LONG_GESTURE data:longG];
}


@end
