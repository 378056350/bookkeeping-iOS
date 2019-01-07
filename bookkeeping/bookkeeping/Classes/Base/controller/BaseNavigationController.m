/**
 * 导航栏
 * @author 郑业强 2018-03-19
 */

#import "BaseNavigationController.h"

#pragma mark - 声明
@interface BaseNavigationController ()

@end

#pragma mark - 实现
@implementation BaseNavigationController


#pragma mark - 初始化
+ (instancetype)initWithRootViewController:(UIViewController *)vc {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.jz_navigationBarTransitionStyle = JZNavigationBarTransitionStyleSystem;
    return nav;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        BaseViewController *vc = (BaseViewController *)viewController;
        vc.leftButton.hidden = true;
        vc.hidesBottomBarWhenPushed = true;
    } else {
        BaseViewController *vc = (BaseViewController *)viewController;
        vc.leftButton.hidden = true;
        vc.hidesBottomBarWhenPushed = false;
    }
    
    
//    BaseTabBarController *tab = (BaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    if ([viewController isKindOfClass:[HomeController class]] ||
//        [viewController isKindOfClass:[ChartController class]] ||
//        [viewController isKindOfClass:[BKCController class]] ||
//        [viewController isKindOfClass:[FindController class]] ||
//        [viewController isKindOfClass:[MineController class]]) {
//        BaseViewController *vc = (BaseViewController *)viewController;
//        vc.leftButton.hidden = YES;
////        [tab hideTabbar:NO];
//    }
//    else {
//        BaseViewController *vc = (BaseViewController *)viewController;
//        vc.leftButton.hidden = NO;
//        vc.hidesBottomBarWhenPushed = YES;
////        [tab hideTabbar:YES];
//    }
    
    
    
    [super pushViewController:viewController animated:animated];
}

@end

