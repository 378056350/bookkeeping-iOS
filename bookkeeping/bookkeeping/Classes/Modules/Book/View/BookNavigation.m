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
    
    [self.nameConstraintT setConstant:StatusBarHeight];
    [self.nameConstraintW setConstant:countcoordinatesX(60)];
}


#pragma mark - get
- (UIView *)line {
    if (!_line) {
        CGFloat width = [@"收入" sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:BTN_FONT].width;
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 2)];
        _line.backgroundColor = kColor_Text_Black;
        [self addSubview:_line];
    }
    return _line;
}


@end
