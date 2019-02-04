/**
 * 个人信息
 * @author 郑业强 2019-02-04
 */

#import "CCInfoCell.h"
#import "CCCellConfig.h"

#pragma mark - 声明
@interface CCInfoCell()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) UIButton *showBtn;

@end


#pragma mark - 实现
@implementation CCInfoCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self icon];
    [self nameLab];
    [self textLab];
    [self showBtn];
    [self updateFrame];
}
- (void)updateFrame {
    [_icon setFrame:CGRectMake(CELL_OUT_PADDING_W, CELL_OUT_PADDING_H, CELL_ICON_W, CELL_ICON_H)];
    [_icon setRoundedCorners:UIRectCornerAllCorners radius:countcoordinatesX(2)];
    [_nameLab setFrame:({
        CGFloat height = CELL_FONT(_model.name, CELL_NAME_W, CELL_NAME_FONT);
        CGRectMake(CELL_NAME_L, _icon.top, CELL_NAME_W, height);
    })];
    [_textLab setFrame:({
        CGFloat width = _nameLab.width;
        CGFloat height = [_model.text sizeWithMaxSize:CGSizeMake(width, MAXFLOAT) font:CELL_TEXT_FONT lineHeight:countcoordinatesX(3)].height;
        CGRectMake(_nameLab.left, _nameLab.bottom + countcoordinatesX(5), width, height);
    })];
    [_showBtn setLeft:_nameLab.left];
    [_showBtn setTop:_textLab.bottom];
}
+ (CGFloat)getCellHeight:(CCModel *)model {
    if (model.isShow == true) {
        CGFloat textH = [model.text sizeWithMaxSize:CGSizeMake(CELL_NAME_W, MAXFLOAT) font:CELL_TEXT_FONT lineHeight:countcoordinatesX(3)].height;
        
        
        CGFloat height = 0;
        height += CELL_OUT_PADDING_H;
        height += CELL_FONT(model.name, CELL_NAME_W, CELL_NAME_FONT);
        height += (model.text.length == 0 ? 0 : textH);
        height += CELL_IN_PADDING_H;
        return height;
    } else {
        return countcoordinatesX(100);
    }
}


#pragma mark - set
- (void)setModel:(CCModel *)model {
    _model = model;
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    [_nameLab setText:model.name];
    [_textLab setAttributedText:({
        NSString *string = model.text;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = countcoordinatesX(3);
        NSDictionary *attributes = @{NSFontAttributeName: CELL_TEXT_FONT,
                                     NSFontAttributeName: kColor_Text_Black,
                                     NSParagraphStyleAttributeName: style
                                     };
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:string attributes:attributes];
        attr;
    })];
    [self updateFrame];
}


#pragma mark - 点击
- (void)showBtnClick:(UIButton *)button {
    [button setSelected:button.selected];
    [self routerEventWithName:CELL_SHOW_CLICK data:self];
}


#pragma mark - 控件
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_icon setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_icon];
    }
    return _icon;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLab.font = CELL_NAME_FONT;
        _nameLab.textColor = kColor_Text_Black;
        [self.contentView addSubview:_nameLab];
    }
    return _nameLab;
}
- (UILabel *)textLab {
    if (!_textLab) {
        _textLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLab.numberOfLines = 0;
        [self.contentView addSubview:_textLab];
    }
    return _textLab;
}
- (UIButton *)showBtn {
    if (!_showBtn) {
        NSString *str = @"显示";
        UIFont *font = [UIFont systemFontOfSize:AdjustFont(14)];
        CGSize size = [str sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:font];
        
        _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showBtn setTitle:str forState:UIControlStateNormal];
        [_showBtn.titleLabel setFont:font];
        [_showBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [_showBtn setBackgroundColor:[UIColor redColor]];
        [_showBtn setWidth:size.width + countcoordinatesX(20)];
        [_showBtn setHeight:size.height + countcoordinatesX(10)];
        [_showBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_showBtn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_showBtn setHidden:true];
        [self.contentView addSubview:_showBtn];
    }
    return _showBtn;
}


@end
