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
//    nav.jz_navigationBarTransitionStyle = JZNavigationBarTransitionStyleSystem;
    return nav;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
////    BaseTabBarController *tab = (BaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    if ([viewController isKindOfClass:[HomeController class]] ||
//        [viewController isKindOfClass:[SortController class]] ||
//        [viewController isKindOfClass:[MessageController class]] ||
//        [viewController isKindOfClass:[CartController class]] ||
//        [viewController isKindOfClass:[MineController class]]) {
//        BaseViewController *vc = (BaseViewController *)viewController;
//        vc.leftButton.hidden = YES;
//        
////        [tab hideTabbar:NO];
//    }
//    else {
//        BaseViewController *vc = (BaseViewController *)viewController;
//        vc.leftButton.hidden = NO;
////        [tab hideTabbar:YES];
//    }
    
//    viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:animated];
}

@end

