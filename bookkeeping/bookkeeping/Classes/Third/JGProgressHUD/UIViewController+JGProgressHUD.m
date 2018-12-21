//
//  UIViewController+JGProgressHUD.m
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/13.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UIViewController+JGProgressHUD.h"

@implementation UIViewController (JGProgressHUD)

- (void)setHud:(JGProgressHUD *)hud {
    
}
- (JGProgressHUD *)hud {
    return self.hud;
}
- (void)setWindow_hud:(JGProgressHUD *)window_hud {
    
}
- (JGProgressHUD *)window_hud {
    return [UIApplication sharedApplication].keyWindow.hud;
}
- (void)setHud_type:(JGProgressHUDInteractionType)hud_type {
    [self.view setHud_type:hud_type];
}
- (JGProgressHUDInteractionType)hud_type {
    return self.view.hud_type;
}
- (void)setWindow_hud_type:(JGProgressHUDInteractionType)window_hud_type {
    [[UIApplication sharedApplication].keyWindow setHud_type:window_hud_type];
}
- (JGProgressHUDInteractionType)window_hud_type {
    return [UIApplication sharedApplication].keyWindow.hud_type;
}
- (void)setHud_animation:(BOOL)hud_animation {
    [self.view setHud_animation:hud_animation];
}
- (BOOL)hud_animation {
    return [self.view hud_animation];
}
- (void)setJg_progress:(CGFloat)jg_progress {
    [self.view setJg_progress:jg_progress];
}
- (CGFloat)jg_progress {
    return self.view.jg_progress;
}
- (void)setHud_hasBack:(BOOL)hud_hasBack {
    [self.view setHud_hasBack:hud_hasBack];
}
- (BOOL)hud_hasBack {
    return self.view.hud_hasBack;
}

#pragma mark - 成功
- (void)showSuccessHUD {
    [self.view showSuccessHUD];
}
- (void)showSuccessHUD:(NSString *)text {
    [self.view showSuccessHUD:text];
}
- (void)showSuccessHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [self.view showSuccessHUD:text delay:delay];
}


#pragma mark - 失败
- (void)showErrorHUD {
    [self.view showErrorHUD];
}
- (void)showErrorHUD:(NSString *)text {
    [self.view showErrorHUD:text];
}
- (void)showErrorHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [self.view showErrorHUD:text delay:delay];
}


#pragma mark - 等待
- (void)showProgressHUD {
    [self.view showProgressHUD];
}
- (void)showProgressHUD:(NSString *)text {
    [self.view showProgressHUD:text];
}
- (void)showProgressHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [self.view showProgressHUD:text delay:delay];
}


#pragma mark - 等待圈
- (void)showDownloadHUD {
    [self.view showDownloadHUD];
}
- (void)showDownloadHUD:(NSString *)text {
    [self.view showDownloadHUD:text];
}
- (void)showDownloadHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [self showDownloadHUD:text delay:delay];
}


- (void)showTextHUD:(NSString *)text {
    [self.view showTextHUD:text];
}
- (void)showTextHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [self.view showTextHUD:text delay:delay];
}


#pragma mark - 隐藏
- (void)hideHUD {
    [self.view hideHUD];
}
- (void)hideHUD:(NSTimeInterval)delay {
    [self.view hideHUD:delay];
}


//================================= window =================================//

#pragma mark - 成功
- (void)showWindowSuccessHUD {
    [[UIApplication sharedApplication].keyWindow showWindowSuccessHUD];
}
- (void)showWindowSuccessHUD:(NSString *)text {
    [[UIApplication sharedApplication].keyWindow showWindowSuccessHUD:text];
}
- (void)showWindowSuccessHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [[UIApplication sharedApplication].keyWindow showWindowSuccessHUD:text delay:delay];
}


#pragma mark - 错误
- (void)showWindowErrorHUD {
    [[UIApplication sharedApplication].keyWindow showWindowErrorHUD];
}
- (void)showWindowErrorHUD:(NSString *)text {
    [[UIApplication sharedApplication].keyWindow showWindowErrorHUD:text];
}
- (void)showWindowErrorHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [[UIApplication sharedApplication].keyWindow showWindowErrorHUD:text delay:delay];
}


#pragma mark - 等待
- (void)showWindowProgressHUD {
    [[UIApplication sharedApplication].keyWindow showWindowProgressHUD];
}
- (void)showWindowProgressHUD:(NSString *)text {
    [[UIApplication sharedApplication].keyWindow showWindowProgressHUD:text];
}
- (void)showWindowProgressHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [[UIApplication sharedApplication].keyWindow showWindowProgressHUD:text delay:delay];
}


#pragma mark - 等待圈
- (void)showWindowDownloadHUD {
    [[UIApplication sharedApplication].keyWindow showWindowDownloadHUD];
}
- (void)showWindowDownloadHUD:(NSString *)text {
    [[UIApplication sharedApplication].keyWindow showWindowDownloadHUD:text];
}
- (void)showWindowDownloadHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [[UIApplication sharedApplication].keyWindow showWindowDownloadHUD:text delay:delay];
}


- (void)showWindowTextHUD:(NSString *)text {
    [[UIApplication sharedApplication].keyWindow showWindowTextHUD:text];
}
- (void)showWindowTextHUD:(NSString *)text delay:(NSTimeInterval)delay {
    [[UIApplication sharedApplication].keyWindow showWindowTextHUD:text delay:delay];
}


#pragma mark - 隐藏
- (void)hideWindowHUD {
    [[UIApplication sharedApplication].keyWindow hideWindowHUD];
}
- (void)hideWindowHUD:(NSTimeInterval)delay {
    [[UIApplication sharedApplication].keyWindow hideWindowHUD:delay];
}



@end
