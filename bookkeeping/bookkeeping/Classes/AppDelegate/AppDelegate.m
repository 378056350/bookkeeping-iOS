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
    return YES;
}
// 跟控制器
- (void)makeRootController {
    [self setWindow:[[UIWindow alloc] initWithFrame:SCREEN_BOUNDS]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:({
        BaseTabBarController *tab = [[BaseTabBarController alloc] init];
        tab;
    })];
    [self.window makeKeyAndVisible];
}


@end
