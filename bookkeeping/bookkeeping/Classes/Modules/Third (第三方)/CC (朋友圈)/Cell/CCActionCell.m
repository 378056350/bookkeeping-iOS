/**
 * 操作
 * @author 郑业强 2019-02-04
 */

#import "CCActionCell.h"
#import "CCCellConfig.h"

#pragma mark - 声明
@interface CCActionCell()

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *actionBtn;

@end


#pragma mark - 实现
@implementation CCActionCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self nameLab];
    [self actionBtn];
}

+ (CGFloat)getCellHeight:(CCModel *)model {
    return CELL_ACTION_H;
}


#pragma mark - get
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CELL_NAME_L, 0, 80, CELL_ACTION_H)];
        _nameLab.font = CELL_TIME_FONT;
        _nameLab.textColor = kColor_Text_Gary;
        _nameLab.text = @"12分钟前";
        [self.contentView addSubview:_nameLab];
    }
    return _nameLab;
}
- (UIButton *)actionBtn {
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionBtn.backgroundColor = [UIColor redColor];
        _actionBtn.frame = ({
            CGFloat width = 80;
            CGFloat height = CELL_ACTION_H;
            CGFloat left = SCREEN_WIDTH - width - CELL_OUT_PADDING_W;
            CGRectMake(left, 0, width, height);
        });
        [self.contentView addSubview:_actionBtn];
    }
    return _actionBtn;
}


@end
