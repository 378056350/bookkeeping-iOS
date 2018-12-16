//
//  AppDelegate.m
//  bookkeeping
//
//  Created by zhongke on 2018/12/16.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "AppDelegate.h"

#pragma mark - 声明
@interface AppDelegate ()

@end


#pragma mark - 实现
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self makeRootController];
    [self makeConfig];
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
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kColor_Text_Gary, NSFontAttributeName : [UIFont systemFontOfSize:AdjustFont(18)]}];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[kColor_Text_Black colorWithAlphaComponent:0.5], NSForegroundColorAttributeName, [UIFont systemFontOfSize:AdjustFont(10)],NSFontAttributeName,nil] forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MainColor, NSForegroundColorAttributeName, [UIFont systemFontOfSize:AdjustFont(10)],NSFontAttributeName,nil] forState:UIControlStateSelected];
}


@end
