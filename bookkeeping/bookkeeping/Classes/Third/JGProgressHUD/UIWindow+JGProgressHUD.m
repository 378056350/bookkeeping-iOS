//
//  UIWindow+JGProgressHUD.m
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/14.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UIWindow+JGProgressHUD.h"

@implementation UIWindow (JGProgressHUD)


#pragma mark - 成功
- (void)showWindowSuccessHUD {
    [self showWindowSuccessHUD:@"" delay:10000];
}
- (void)showWindowSuccessHUD:(NSString *)text {
    [self showWindowSuccessHUD:text delay:10000];
}
- (void)showWindowSuccessHUD:(NSString *)text delay:(NSTimeInterval)delay {
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:type];
    [HUD.textLabel setText:text];
    [HUD setVibrancyEnabled:NO];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD setIndicatorView:[[JGProgressHUDSuccessIndicatorView alloc] init]];
    [HUD setSquare:YES];
    [HUD showInView:self];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    self.hud = HUD;
}


#pragma mark - 错误
- (void)showWindowErrorHUD {
    [self showWindowErrorHUD:@"" delay:10000];
}
- (void)showWindowErrorHUD:(NSString *)text {
    [self showWindowErrorHUD:text delay:10000];
}
- (void)showWindowErrorHUD:(NSString *)text delay:(NSTimeInterval)delay {
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:type];
    [HUD.textLabel setText:text];
    [HUD setVibrancyEnabled:NO];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD setIndicatorView:[[JGProgressHUDErrorIndicatorView alloc] init]];
    [HUD setSquare:YES];
    [HUD showInView:self];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    self.hud = HUD;
}


#pragma mark - 等待
- (void)showWindowProgressHUD {
    [self showWindowProgressHUD:@"" delay:10000];
}
- (void)showWindowProgressHUD:(NSString *)text {
    [self showWindowProgressHUD:text delay:10000];
}
- (void)showWindowProgressHUD:(NSString *)text delay:(NSTimeInterval)delay {
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:type];
    [HUD.textLabel setText:text];
    [HUD setVibrancyEnabled:NO];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD setSquare:YES];
    [HUD showInView:self];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    self.hud = HUD;
}


#pragma mark - 等待圈
- (void)showWindowDownloadHUD {
    [self showWindowDownloadHUD];
    
}
- (void)showWindowDownloadHUD:(NSString *)text {
    [self showWindowDownloadHUD:text delay:10000];
}
- (void)showWindowDownloadHUD:(NSString *)text delay:(NSTimeInterval)delay {
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:type];
    [HUD setVibrancyEnabled:NO];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD setSquare:YES];
    [HUD setIndicatorView:[[JGProgressHUDRingIndicatorView alloc] init]];
    [HUD showInView:self];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    [HUD.textLabel setText:text];
    [HUD.detailTextLabel setText:@"0% Complete"];
    self.hud = HUD;
}


- (void)showWindowTextHUD:(NSString *)text {
    [self showWindowTextHUD:text delay:10000];
}
- (void)showWindowTextHUD:(NSString *)text delay:(NSTimeInterval)delay {
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:nil];
    [HUD setPosition:JGProgressHUDPositionBottomCenter];
    [HUD setVibrancyEnabled:NO];
    [HUD setIndicatorView:nil];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD.textLabel setAttributedText:({
        NSDictionary *param = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                NSFontAttributeName: [UIFont systemFontOfSize:AdjustFont(12)]};
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text attributes:param];
        attr;
    })];
    [HUD showInView:self];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    self.hud = HUD;
}


#pragma mark - 隐藏
- (void)hideWindowHUD {
    [self.hud dismissAnimated:self.hud_animation];
}
- (void)hideWindowHUD:(NSTimeInterval)delay {
    [self.hud dismissAfterDelay:delay animated:self.hud_animation];
}

@end
