//
//  UIView+JGProgressHUD.h
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/13.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JGProgressHUD/JGProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JGProgressHUD)<JGProgressHUDDelegate>

@property (nonatomic, strong) JGProgressHUD *hud;
@property (nonatomic, assign) JGProgressHUDInteractionType hud_type;    // 是否可以点击
@property (nonatomic, assign) BOOL hud_animation;                       // 隐藏是否有动画
@property (nonatomic, assign) BOOL hud_hasBack;                         // 是否有背景色
@property (nonatomic, assign) CGFloat jg_progress;


#pragma mark - 成功
- (void)showSuccessHUD;
- (void)showSuccessHUD:(NSString *)text;
- (void)showSuccessHUD:(NSString *)text delay:(NSTimeInterval)delay;


#pragma mark - 错误
- (void)showErrorHUD;
- (void)showErrorHUD:(NSString *)text;
- (void)showErrorHUD:(NSString *)text delay:(NSTimeInterval)delay;


#pragma mark - 等待
- (void)showProgressHUD;
- (void)showProgressHUD:(NSString *)text;
- (void)showProgressHUD:(NSString *)text delay:(NSTimeInterval)delay;


#pragma mark - 等待圈
- (void)showDownloadHUD;
- (void)showDownloadHUD:(NSString *)text;
- (void)showDownloadHUD:(NSString *)text delay:(NSTimeInterval)delay;


- (void)showTextHUD:(NSString *)text;
- (void)showTextHUD:(NSString *)text delay:(NSTimeInterval)delay;


#pragma mark - 隐藏
- (void)hideHUD;
- (void)hideHUD:(NSTimeInterval)delay;




//================================= window =================================//

#pragma mark - 成功
- (void)showWindowSuccessHUD;
- (void)showWindowSuccessHUD:(NSString *)text;
- (void)showWindowSuccessHUD:(NSString *)text delay:(NSTimeInterval)delay;


#pragma mark - 错误
- (void)showWindowErrorHUD;
- (void)showWindowErrorHUD:(NSString *)text;
- (void)showWindowErrorHUD:(NSString *)text delay:(NSTimeInterval)delay;


#pragma mark - 等待
- (void)showWindowProgressHUD;
- (void)showWindowProgressHUD:(NSString *)text;
- (void)showWindowProgressHUD:(NSString *)text delay:(NSTimeInterval)delay;


#pragma mark - 等待圈
- (void)showWindowDownloadHUD;
- (void)showWindowDownloadHUD:(NSString *)text;
- (void)showWindowDownloadHUD:(NSString *)text delay:(NSTimeInterval)delay;


- (void)showWindowTextHUD:(NSString *)text;
- (void)showWindowTextHUD:(NSString *)text delay:(NSTimeInterval)delay;


#pragma mark - 隐藏
- (void)hideWindowHUD;
- (void)hideWindowHUD:(NSTimeInterval)delay;


@end

NS_ASSUME_NONNULL_END
