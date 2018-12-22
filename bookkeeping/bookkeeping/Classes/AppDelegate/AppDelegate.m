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
    [self makeRootController];
    [self makeConfig];
    [self shareUMengConfig];
    return YES;
}
// 根控制器
- (void)makeRootController {
    [self setWindow:[[UIWindow alloc] initWithFrame:SCREEN_BOUNDS]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:({
        BaseTabBarController *tab = [[BaseTabBarController alloc] init];
        tab;
    })];
    [self.window makeKeyAndVisible];
}
// 配置
- (void)makeConfig {
    [[UITextField appearance] setTintColor:kColor_Main_Color];
}



// 支持所有iOS系统
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        
    }
    return result;
}




@end
