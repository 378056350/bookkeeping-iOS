//
//  ASBaseViewController.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/7.
//  Copyright © 2019 kk. All rights reserved.
//

#import "ASBaseViewController.h"

#pragma mark - 声明
@interface ASBaseViewController()

@end


#pragma mark - 实现
@implementation ASBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kColor_BG];
    [self.node setBackgroundColor:kColor_BG];
    [self initUI];
}
- (void)initUI {
    [self setLeftBtn];
    [self setRightBtn];
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
    
    
    
    
//    if ([self isKindOfClass:[HomeController class]] ||
//        [self isKindOfClass:[ChartController class]] ||
//        [self isKindOfClass:[BKCController class]] ||
//        [self isKindOfClass:[FindController class]] ||
//        [self isKindOfClass:[MineController class]]) {
//        self.leftButton.hidden = YES;
//    } else {
//        self.leftButton.hidden = NO;
//    }
    
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


@end
