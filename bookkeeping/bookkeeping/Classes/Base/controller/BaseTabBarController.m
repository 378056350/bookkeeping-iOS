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
    [self addChildViewController:home title:@"明细" image:@"tabbar_detail_n" selImage:@"tabbar_detail_s"];

    ChartController *sort = [[ChartController alloc] init];
    [self addChildViewController:sort title:@"图表" image:@"tabbar_chart_n" selImage:@"tabbar_chart_s"];

    BaseViewController *message = [[BaseViewController alloc] init];
    [self addChildViewController:message title:@"记账" image:@"tabbar_add_n" selImage:@"tabbar_add_h"];

    FindController *cart = [[FindController alloc] init];
    [self addChildViewController:cart title:@"发现" image:@"tabbar_discover_n" selImage:@"tabbar_discover_s"];

    MineController *mine = [[MineController alloc] init];
    [self addChildViewController:mine title:@"我的" image:@"tabbar_mine_n" selImage:@"tabbar_mine_s"];
    
    
//    [self setSelectedIndex:4];
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
        @weakify(self)
        for (UIView *view in self.tabBar.subviews) {
            [view removeFromSuperview];
        }
        
        _bar = [[BaseTabBar alloc] init];
        [_bar setClick:^(NSInteger index) {
            @strongify(self)
            // 记账
            if (index == 2) {
                BKCController *vc = [[BKCController alloc] init];
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
            }
            else {
                // 我的
                if (index == 4) {
                    BaseNavigationController *nav = self.viewControllers[index];
                    MineController *vc = nav.viewControllers[0];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [vc.mine.table setContentOffset:CGPointZero animated:true];
                    });
                }
                [self setSelectedIndex:index];
                [self.bar setIndex:index];
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
