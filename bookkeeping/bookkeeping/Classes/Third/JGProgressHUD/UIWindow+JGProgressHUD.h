//
//  UIWindow+JGProgressHUD.h
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/14.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (JGProgressHUD)

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
