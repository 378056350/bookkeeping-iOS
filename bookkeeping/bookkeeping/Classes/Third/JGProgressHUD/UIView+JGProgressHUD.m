//
//  UIView+JGProgressHUD.m
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/13.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UIView+JGProgressHUD.h"
#import "NSObject+JGRuntime.h"

static NSString *jgHudSetGetKey = @"jgHudSetGetKey";
static NSString *jgProgressSetGetKey = @"jgProgressSetGetKey";
static NSString *jgAnimationSetGetKey = @"jgAnimationSetGetKey";
static NSString *jgBackSetGetKey = @"jgBackSetGetKey";


@implementation UIView (JGProgressHUD)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithOriginSel:@selector(init)
                                     swizzledSel:@selector(hook_init)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(initWithFrame:)
                                     swizzledSel:@selector(hook_initWithFrame:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(initWithCoder:)
                                     swizzledSel:@selector(hook_initWithCoder:)];
    });
}
- (instancetype)hook_init {
    id obj =  [self hook_init];
    [obj initData];
    return obj;
}
- (instancetype)hook_initWithFrame:(CGRect)frame {
    id obj = [self hook_initWithFrame:frame];
    [obj initData];
    return obj;
}
- (instancetype)hook_initWithCoder:(NSCoder *)aDecoder {
    id obj = [self hook_initWithCoder:aDecoder];
    [obj initData];
    return obj;
}
- (void)initData {
    [self setHud_animation:YES];
    [self setHud_hasBack:NO];
    [self setHud_type:JGProgressHUDInteractionTypeBlockNoTouches];
}


- (void)setHud:(JGProgressHUD *)hud {
    objc_setAssociatedObject(self, &jgHudSetGetKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (JGProgressHUD *)hud {
    return objc_getAssociatedObject(self, &jgHudSetGetKey);
}

- (void)setHud_type:(JGProgressHUDInteractionType)hud_type {
    objc_setAssociatedObject(self, &jgProgressSetGetKey, @(hud_type), OBJC_ASSOCIATION_ASSIGN);
}
- (JGProgressHUDInteractionType)hud_type {
    return [objc_getAssociatedObject(self, &jgProgressSetGetKey) integerValue];
}

- (void)setHud_animation:(BOOL)hud_animation {
    objc_setAssociatedObject(self, &jgAnimationSetGetKey, @(hud_animation), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)hud_animation {
    return [objc_getAssociatedObject(self, &jgAnimationSetGetKey) boolValue];
}

- (void)setJg_progress:(CGFloat)jg_progress {
    objc_setAssociatedObject(self, &jgProgressSetGetKey, @(jg_progress), OBJC_ASSOCIATION_ASSIGN);
    [self.hud setProgress:jg_progress / 100.0f animated:YES];
    [self.hud.detailTextLabel setText:[NSString stringWithFormat:@"%.0f%% Complete", jg_progress]];
}
- (CGFloat)jg_progress {
    return [objc_getAssociatedObject(self, &jgProgressSetGetKey) floatValue];
}

- (void)setHud_hasBack:(BOOL)hud_hasBack {
    objc_setAssociatedObject(self, &jgBackSetGetKey, @(hud_hasBack), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)hud_hasBack {
    return [objc_getAssociatedObject(self, &jgBackSetGetKey) boolValue];
}


#pragma mark - 成功
- (void)showSuccessHUD {
    [self showSuccessHUD:@"" delay:10000];
}
- (void)showSuccessHUD:(NSString *)text {
    [self showSuccessHUD:text delay:10000];
}
- (void)showSuccessHUD:(NSString *)text delay:(NSTimeInterval)delay {
    if (!self.viewController.navigationController.view) {
        return;
    }
    if (self.hud) {
        [self hideHUD];
    }
    
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:type];
    if (self.hud_hasBack) {
        HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    }
    [HUD.textLabel setText:text];
    [HUD setVibrancyEnabled:NO];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD setIndicatorView:[[JGProgressHUDSuccessIndicatorView alloc] init]];
    [HUD setSquare:YES];
    [HUD showInView:self.viewController.navigationController.view];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    self.hud = HUD;
}


#pragma mark - 错误
- (void)showErrorHUD {
    [self showErrorHUD:@"" delay:10000];
}
- (void)showErrorHUD:(NSString *)text {
    [self showErrorHUD:text delay:10000];
}
- (void)showErrorHUD:(NSString *)text delay:(NSTimeInterval)delay {
    if (!self.viewController.navigationController.view) {
        return;
    }
    
    if (self.hud) {
        [self hideHUD];
    }
    
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:type];
    if (self.hud_hasBack) {
        HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    }
    [HUD.textLabel setText:text];
    [HUD setVibrancyEnabled:NO];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD setIndicatorView:[[JGProgressHUDErrorIndicatorView alloc] init]];
    [HUD setSquare:YES];
    [HUD showInView:self.viewController.navigationController.view];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    self.hud = HUD;
}


#pragma mark - 等待
- (void)showProgressHUD {
    [self showProgressHUD:@"" delay:10000];
}
- (void)showProgressHUD:(NSString *)text {
    [self showProgressHUD:text delay:10000];
}
- (void)showProgressHUD:(NSString *)text delay:(NSTimeInterval)delay {
    if (!self.viewController.navigationController.view) {
        return;
    }
    if (self.hud) {
        [self hideHUD];
    }
    
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:type];
    if (self.hud_hasBack) {
        HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    }
    [HUD.textLabel setText:text];
    [HUD setVibrancyEnabled:NO];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD setSquare:YES];
    [HUD showInView:self.viewController.navigationController.view];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    self.hud = HUD;
}


#pragma mark - 等待圈
- (void)showDownloadHUD {
    [self showDownloadHUD:@"" delay:10000];
}
- (void)showDownloadHUD:(NSString *)text {
    [self showDownloadHUD:text delay:10000];
}
- (void)showDownloadHUD:(NSString *)text delay:(NSTimeInterval)delay {
    if (!self.viewController.navigationController.view) {
        return;
    }
    if (self.hud) {
        [self hideHUD];
    }
    
    JGProgressHUDInteractionType type = self.hud_type;
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    [HUD setInteractionType:type];
    if (self.hud_hasBack) {
        HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    }
    [HUD setVibrancyEnabled:NO];
    [HUD setShadow:[JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f]];
    [HUD setSquare:YES];
    [HUD setIndicatorView:[[JGProgressHUDRingIndicatorView alloc] init]];
    [HUD showInView:self.viewController.navigationController.view];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    [HUD.textLabel setText:text];
    [HUD.detailTextLabel setText:@"0% Complete"];
    self.hud = HUD;
}


#pragma mark - 纯文本
- (void)showTextHUD:(NSString *)text {
    [self showTextHUD:text delay:10000];
}
- (void)showTextHUD:(NSString *)text delay:(NSTimeInterval)delay {
    if (!self.viewController.navigationController.view) {
        return;
    }
    if (self.hud) {
        [self hideHUD];
    }
    
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
    [HUD showInView:self.viewController.navigationController.view];
    [HUD dismissAfterDelay:delay animated:self.hud_animation];
    self.hud = HUD;
}


#pragma mark - 隐藏
- (void)hideHUD {
    [self.hud dismissAnimated:self.hud_animation];
}
- (void)hideHUD:(NSTimeInterval)delay {
    [self.hud dismissAfterDelay:delay animated:self.hud_animation];
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
