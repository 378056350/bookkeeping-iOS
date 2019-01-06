/**
 * 添加记账导航栏
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BKCNavigation.h"
#import "BOOK_EVENT.h"

#define BTN_FONT [UIFont systemFontOfSize:AdjustFont(16)]

#pragma mark - 声明
@interface BKCNavigation()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (nonatomic, strong) UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintW;

@end

#pragma mark - 实现
@implementation BKCNavigation


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
        [self routerEventWithName:BOOK_CLICK_NAVIGATION data:@(0)];
    }];
    [[self.btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self routerEventWithName:BOOK_CLICK_NAVIGATION data:@(1)];
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
    [self setIndex:index animation:NO];
}
- (void)setIndex:(NSInteger)index animation:(BOOL)animation {
    _index = index;
    NSTimeInterval time = animation == true ? 0.3f : 0;
    @weakify(self)
    [UIView animateWithDuration:time animations:^{
        @strongify(self)
        if (index == 0) {
            self.line.centerX = self.btn1.left + self.btn1.width / 2;
        } else if (index == 1) {
            self.line.centerX = self.btn2.left + self.btn2.width / 2;
        }
    }];
}
- (void)setOffsetX:(CGFloat)offsetX {
    offsetX = offsetX / SCREEN_WIDTH * countcoordinatesX(60);
    _offsetX = offsetX;
    
    
    
    _line.left = _btn1.left + offsetX + (countcoordinatesX(60) - [@"收入" sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:BTN_FONT].width) / 2;
}


- (IBAction)cancleClick:(UIButton *)sender {
    if (self.viewController.navigationController.viewControllers.count != 1) {
        [self.viewController.navigationController popViewControllerAnimated:true];
    } else {
        [self.viewController.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
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
