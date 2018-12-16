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
- (instancetype)init {
    if (self = [super init]) {
//        if ([self isKindOfClass:[HomeController class]] ||
//            [self isKindOfClass:[SortController class]] ||
//            [self isKindOfClass:[MessageController class]] ||
//            [self isKindOfClass:[CartController class]] ||
//            [self isKindOfClass:[MineController class]]) {
//            self.hidesBottomBarWhenPushed = NO;
//        }
//        else {
//            self.hidesBottomBarWhenPushed = YES;
//        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setJz_navigationBarTransitionStyle:JZNavigationBarTransitionStyleSystem];
//    [self setJz_navigationBarTintColor:MainColor];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    [self.view setBackgroundColor:kColor_BG];
    [self initUI];
}
- (void)initUI {
    [self setLeftBtn];
    [self setRightBtn];
}
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    UIFont *font = [UIFont boldSystemFontOfSize:AdjustFont(16)];
    CGSize maxSize = [navTitle sizeWithMaxSize:CGSizeMake(MAXFLOAT, 0) font:font];
    UIButton *btn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = font;
        [btn setFrame:CGRectMake(0, 0, maxSize.width, 40)];
        [btn setTitleColor:kColor_White forState:UIControlStateNormal];
        [btn setTitle:navTitle forState:UIControlStateNormal];
        btn;
    });
    self.navigationItem.titleView = btn;
}
//
//- (void)loadView {
//    self.view = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    self.content = (BaseView *)self.view;
//}

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
        [btn setImage:[UIImage imageNamed:@"cm2_act_view_btn_back"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"cm2_act_view_btn_back_prs"] forState:UIControlStateHighlighted];
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [btn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(0, 0, 40, 40)];
        [btn setContentMode:UIViewContentModeLeft];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        btn;
    });
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barBtn;
    self.leftButton = btn;




//    if ([self isKindOfClass:[HomeController class]] ||
//        [self isKindOfClass:[SortController class]] ||
//        [self isKindOfClass:[MessageController class]] ||
//        [self isKindOfClass:[CartController class]] ||
//        [self isKindOfClass:[MineController class]]) {
//        self.leftButton.hidden = YES;
//    } else {
//        self.leftButton.hidden = NO;
//    }

//    if ([self isKindOfClass:[HomeController class]] ||
//        [self isKindOfClass:[SheetController class]] ||
//        [self isKindOfClass:[MineController class]]) {
//        self.leftButton.hidden = YES;
//    }
//    else {
//        self.leftButton.hidden = NO;
//    }

}
// 设置右侧按钮
- (void)setRightBtn {
    UIButton *btn = ({
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:@"cm2_live_btn_back"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"cm2_live_btn_back_prs"] forState:UIControlStateHighlighted];
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [btn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [btn setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, -4)];
        [btn sizeToFit];
        btn;
    });
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barBtn;
    self.rightButton = btn;
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFont(14)];
    self.rightButton.hidden = YES;
}
// 请求进度
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
//    self.view.progress = progress;
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
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

//    BaseTabBarController *tab = (BaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    if ([self isKindOfClass:[HomeController class]] ||
//        [self isKindOfClass:[SortController class]] ||
//        [self isKindOfClass:[MessageController class]] ||
//        [self isKindOfClass:[CartController class]] ||
//        [self isKindOfClass:[MineController class]]) {
//        [tab hideTabbar:NO];
//    }
//    else {
//        [tab hideTabbar:YES];
//    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end




