//
//  UIViewController+Extension.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/1/8.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

+ (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    do {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)rootVC;
            UIViewController *vc = [navi.viewControllers lastObject];
            result = vc;
            rootVC = vc.presentedViewController;
            continue;
        } else if([rootVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)rootVC;
            result = tab;
            rootVC = [tab.viewControllers objectAtIndex:tab.selectedIndex];
            continue;
        } else if([rootVC isKindOfClass:[UIViewController class]]) {
            result = rootVC;
            rootVC = nil;
        }
    } while (rootVC != nil);
    
    return result;
}


@end
