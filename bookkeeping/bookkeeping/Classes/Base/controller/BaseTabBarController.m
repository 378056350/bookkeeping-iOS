//
//  BaseTabBarController.m
//  iOS
//
//  Created by RY on 2018/3/19.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabBar.h"

#pragma mark - 声明
@interface BaseTabBarController ()

@property (nonatomic, strong) BaseTabBar *bar;

@end

#pragma mark - 实现
@implementation BaseTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    HomeController *home = [[HomeController alloc] init];
//    [self addChildViewController:home title:@"首页" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];
//
//    SortController *sort = [[SortController alloc] init];
//    [self addChildViewController:sort title:@"分类" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];
//
//    MessageController *message = [[MessageController alloc] init];
//    [self addChildViewController:message title:@"消息" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];
//
//    CartController *cart = [[CartController alloc] init];
//    [self addChildViewController:cart title:@"购物车" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];
//
//    MineController *mine = [[MineController alloc] init];
//    [self addChildViewController:mine title:@"个人" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];
    
    
//    [self setSelectedIndex:1];
}

- (void)hideTabbar:(BOOL)hidden {
    [UIView animateWithDuration:.3f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tabBar.top = SCREEN_HEIGHT - (hidden == YES ? 0 : TabbarHeight);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)addChildViewController:(BaseViewController *)childVc title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    static NSInteger index = 0;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.tag = index;
    childVc.navTitle = title;
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[kColor_Text_Black colorWithAlphaComponent:0.5], NSForegroundColorAttributeName, [UIFont systemFontOfSize:AdjustFont(10)],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MainColor, NSForegroundColorAttributeName, [UIFont systemFontOfSize:AdjustFont(10)],NSFontAttributeName,nil] forState:UIControlStateSelected];
    index++;
    
    // 让子控制器包装一个导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


#pragma mark - set
- (void)setIndex:(NSInteger)index {
    _index = index;
    _bar.index = index;
}


#pragma mark - get
- (BaseTabBar *)bar {
    if (!_bar) {
        __weak typeof(self) weakSelf = self;
        for (UIView *view in self.tabBar.subviews) {
            [view removeFromSuperview];
        }
        
        _bar = [[BaseTabBar alloc] init];
        [_bar setClick:^(NSInteger index) {
            // 个人页面
            if (index == 4) {
//                // 登录了
//                if ([UserInfo isLogin]) {
//                    [weakSelf setSelectedIndex:index];
//                    [weakSelf.bar setIndex:index];
//                }
//                // 未登录
//                else {
//                    LoginController *vc = [[LoginController alloc] init];
//                    [vc setLoginBlock:^{
//                        [weakSelf setSelectedIndex:4];
//                        [weakSelf.bar setIndex:4];
//                    }];
//                    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//                    [weakSelf presentViewController:nav animated:YES completion:nil];
//                }
            } else {
                [weakSelf setSelectedIndex:index];
                [weakSelf.bar setIndex:index];
            }
        }];
        [self setValue:_bar forKey:@"tabBar"];
    }
    return _bar;
}


#pragma mark - 系统
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self bar];
}


@end
