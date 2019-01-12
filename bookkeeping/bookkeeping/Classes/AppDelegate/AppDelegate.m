/**
 * 系统配置
 * @author 郑业强 2018-12-16 创建文件
 */

#import "AppDelegate.h"
#import "AppDelegate+UMeng.h"


#pragma mark - 声明
@interface AppDelegate ()

@end


#pragma mark - 实现
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 根控制器
    [self makeRootController];
    // 系统配置
    [self systemConfig];
    // 友盟
    [self shareUMengConfig];
    
    
//    // 注册通知
//    if (@available(iOS 10.0, *)) {
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//            
//        }];
//    }
    
    
    
    
    return YES;
}
// 根控制器
- (void)makeRootController {
    [self setWindow:[[UIWindow alloc] initWithFrame:SCREEN_BOUNDS]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:[[BaseTabBarController alloc] init]];
    [self.window makeKeyAndVisible];
}
// 配置
- (void)systemConfig {
    [[UITextField appearance] setTintColor:kColor_Main_Color];
}



// 支持所有iOS系统
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    // 分享
    if (result) {
        return result;
    }
    // 记一笔
    if ([url.absoluteString isEqualToString:@"kbook://month"]) {
        BaseTabBarController *tab = (BaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        BOOL condition1 = [tab isKindOfClass:[BaseTabBarController class]];
        BOOL condition2 = ![[UIViewController getCurrentVC] isKindOfClass:[BKCController class]];
        if (condition1 && condition2) {
            BKCController *vc = [[BKCController alloc] init];
            UIViewController *current = [UIViewController getCurrentVC];
            if (current.presentedViewController) {
                [current.navigationController pushViewController:vc animated:true];
            } else {
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
                [tab presentViewController:nav animated:true completion:^{
                    
                }];
            }
        }
        return YES;
    }
    // 记账完成
    else if ([url.absoluteString isEqualToString:@"kbook://book"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOT_BOOK_COMPLETE object:nil];
    }
    return result;
}


// 去后台
- (void)applicationWillResignActive:(UIApplication *)application {
    [ScreenBlurry addBlurryScreenImage];
}
// 回前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [ScreenBlurry removeBlurryScreenImage];
}




@end
