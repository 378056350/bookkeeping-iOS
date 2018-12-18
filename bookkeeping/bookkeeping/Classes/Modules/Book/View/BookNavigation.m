/**
 * 列表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BookNavigation.h"

#define BTN_FONT [UIFont systemFontOfSize:AdjustFont(16)]

#pragma mark - 声明
@interface BookNavigation()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (nonatomic, strong) UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintW;

@end

#pragma mark - 实现
@implementation BookNavigation


- (void)initUI {
    [self setBackgroundColor:kColor_Main_Color];
    [self.btn1.titleLabel setFont:BTN_FONT];
    [self.btn1 setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.btn2.titleLabel setFont:BTN_FONT];
    [self.btn2 setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self line];
    @weakify(self)
    [[self.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self setIndex:0];
    }];
    [[self.btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self setIndex:1];
    }];
    [self.cancleBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [[self.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.viewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [self.nameConstraintT setConstant:StatusBarHeight];
    [self.nameConstraintW setConstant:countcoordinatesX(60)];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    if (index == 0) {
        _line.centerX = _btn1.left + _btn1.width / 2;
    } else if (index == 1) {
        _line.centerX = _btn2.left + _btn2.width / 2;
    }
}
- (void)setOffsetX:(CGFloat)offsetX {
    offsetX = offsetX / SCREEN_WIDTH * countcoordinatesX(60);
    _offsetX = offsetX;
    
    
    
    _line.left = _btn1.left + offsetX + (countcoordinatesX(60) - [@"收入" sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:BTN_FONT].width) / 2;
}


#pragma mark - get
- (UIView *)line {
    if (!_line) {
        CGFloat width = [@"收入" sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:BTN_FONT].width;
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom - 2, width, 2)];
        _line.backgroundColor = kColor_Text_Black;
        _line.left = (SCREEN_WIDTH - countcoordinatesX(60) * 2) / 2 + (countcoordinatesX(60) - [@"收入" sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:BTN_FONT].width) / 2;
        [self addSubview:_line];
    }
    return _line;
}


@end
