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
    
    
    HomeController *home = [[HomeController alloc] init];
    [self addChildViewController:home title:@"明细" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];

    ChartController *sort = [[ChartController alloc] init];
    [self addChildViewController:sort title:@"图表" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];

    BaseViewController *message = [[BaseViewController alloc] init];
    [self addChildViewController:message title:@"记账" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];

    FindController *cart = [[FindController alloc] init];
    [self addChildViewController:cart title:@"发现" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];

    MineController *mine = [[MineController alloc] init];
    [self addChildViewController:mine title:@"我的" image:@"cm4_btm_icn_discovery" selImage:@"cm4_btm_icn_discovery_prs"];
    
    
    [self setSelectedIndex:1];
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
            // 记账
            if (index == 2) {
                BookController *vc = [[BookController alloc] init];
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
                [weakSelf presentViewController:nav animated:YES completion:^{
                    
                }];
            }
            else {
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
