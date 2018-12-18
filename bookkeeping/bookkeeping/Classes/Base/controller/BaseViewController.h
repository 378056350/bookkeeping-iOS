//
//  BaseViewController.h
//  iOS
//
//  Created by RY on 2018/3/19.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface BaseViewController : UIViewController

// 标题
@property (nonatomic, strong) NSString *navTitle;
// 是否允许侧滑返回
@property (nonatomic, assign, getter=isAllowBack) BOOL allowPanBack;
// 按钮
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
// 导航栏
@property (nonatomic, strong) UIColor *navColor;


// 点击了返回按钮
- (void)leftButtonClick;
// 点击了右侧按钮
- (void)rightButtonClick;

- (void)hideNavigationBarLine;
- (void)showNavigationBarLine;

- (void)initUI;

@end
