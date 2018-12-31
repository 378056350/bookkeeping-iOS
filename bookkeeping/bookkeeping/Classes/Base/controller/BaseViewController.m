//
//  BaseViewController.m
//  iOS
//
//  Created by RY on 2018/3/19.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseView.h"

#pragma mark - enum
typedef NS_ENUM(NSInteger, BarButtonItemState) {
    BarButtonItemStateLeft,     // 文字居左
    BarButtonItemStateRight,    // 文字居右
};


#pragma mark - 声明
@interface BaseViewController ()

@end


#pragma mark - 实现
@implementation BaseViewController


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setJz_navigationBarTransitionStyle:JZNavigationBarTransitionStyleSystem];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
    [self.view setBackgroundColor:kColor_BG];
    [self initUI];
    for (id obj in self.navigationController.navigationBar.subviews) {
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
            UIView *hook = [(BaseNavigationController *)self.navigationController hook_background];
            [self.navigationController.navigationBar insertSubview:hook belowSubview:obj];
        }
    }
}
- (void)initUI {
    [self setLeftBtn];
    [self setRightBtn];
}
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    UIFont *font = [UIFont systemFontOfSize:AdjustFont(16)];
    CGSize maxSize = [navTitle sizeWithMaxSize:CGSizeMake(MAXFLOAT, 0) font:font];
    UIButton *btn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn.titleLabel setFont:font];
        [btn setFrame:CGRectMake(0, 0, maxSize.width, 40)];
        [btn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [btn setTitle:navTitle forState:UIControlStateNormal];
        btn;
    });
    self.navigationItem.titleView = btn;
}


#pragma mark - 点击
// 点击了返回按钮
- (void)leftButtonClick {
    if ([self.navigationController popViewControllerAnimated:YES] == nil) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
// 点击了右侧按钮
- (void)rightButtonClick {

}


#pragma mark - set
// 设置返回按钮
- (void)setLeftBtn {
    UIButton *btn = ({
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateHighlighted];
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [btn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(0, 0, 40, 40)];
        [btn setContentMode:UIViewContentModeLeft];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(8, -4, 8, 16)];
        btn;
    });
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barBtn;
    self.leftButton = btn;




    if ([self isKindOfClass:[HomeController class]] ||
        [self isKindOfClass:[ChartController class]] ||
        [self isKindOfClass:[BKCController class]] ||
        [self isKindOfClass:[FindController class]] ||
        [self isKindOfClass:[MineController class]]) {
        self.leftButton.hidden = YES;
    } else {
        self.leftButton.hidden = NO;
    }

}
// 设置右侧按钮
- (void)setRightBtn {
    UIButton *btn = ({
        UIButton *btn = [UIButton new];
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [btn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, -4)];
        [btn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [btn setTitleColor:kColor_Text_Black forState:UIControlStateSelected];
        [btn sizeToFit];
        btn;
    });
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barBtn;
    self.rightButton = btn;
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFont(14)];
    self.rightButton.hidden = YES;
}



#pragma mark - 线条
- (void)hideNavigationBarLine {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)showNavigationBarLine {
    [self.navigationController.navigationBar setShadowImage:nil];
}


#pragma mark - 系统
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBarLine];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end




