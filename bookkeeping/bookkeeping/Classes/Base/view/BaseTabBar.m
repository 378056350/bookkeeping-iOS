//
//  BaseTabBar.m
//  weibo-OC
//
//  Created by Oboe_b on 16/8/29.
//  Copyright © 2016年 Oboe_b. All rights reserved.
//

#import "BaseTabBar.h"
#import "UIView+BorderLine.h"

@interface BaseTabBar ()

@property (strong, nonatomic) UIButton *composeButton;
@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation BaseTabBar


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self setBackgroundColor:kColor_White];
    [self setShadowLine:[kColor_Text_Gary colorWithAlphaComponent:0.1]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self views];
    
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [(UIView *)obj setAlpha:0];
            [(UIView *)obj setUserInteractionEnabled:NO];
        }
    }
    
}

- (void)click:(NSInteger)index {
    NSArray<NSArray *> *image = @[
                                  @[@"明细",@"图表",@"记账",@"发现",@"我的"],
                                  @[@"tabbar_detail_n",
                                    @"tabbar_chart_n",
                                    @"tabbar_add_n",
                                    @"tabbar_discover_n",
                                    @"tabbar_mine_n"],
                                  @[@"tabbar_detail_s",
                                    @"tabbar_chart_s",
                                    @"tabbar_add_h",
                                    @"tabbar_discover_s",
                                    @"tabbar_mine_s"]
                                  ];
    
    for (int y=0; y<self.views.count; y++) {
        UIView *subview = self.views[y];
        UIImageView *subicon = [subview viewWithTag:10];
        subicon.image = [UIImage imageNamed:y == index ? image[2][y] : image[1][y]];
        UILabel *sublab = [subview viewWithTag:11];
        sublab.textColor = y == index ? kColor_Text_Gary : kColor_Text_Gary;
        sublab.text = image[0][y];
    }
    
    
    UIImageView *icn = [_views[index] viewWithTag:10];
    [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        icn.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            icn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    CGPoint newPoint = [self convertPoint:point toView:self.views[2]];
    UIImageView *image = [self.views[2] viewWithTag:10];
    // 点击到世界
    if (CGRectContainsPoint(image.frame, newPoint)) {
        // tabbar 显示中
        id obj = [UIApplication sharedApplication].keyWindow.rootViewController;
        if ([obj isKindOfClass:[BaseTabBarController class]]) {
            BaseTabBarController *tab = (BaseTabBarController *)obj;
            BaseNavigationController *nav = tab.viewControllers[tab.selectedIndex];
            if (nav.viewControllers.count == 1) {
                return self.views[2];
            }
        }
    }
    
    return view;
}


#pragma mark - 点击
- (void)setIndex:(NSInteger)index {
    _index = index;
    [self click:index];
}


#pragma mark - set
- (void)setShadowLine:(UIColor *)color {
    // 改变tabbar 线条颜色
    [self setShadowImage:({
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        img;
    })];
    [self setBackgroundImage:[[UIImage alloc] init]];
}


#pragma mark - get
- (NSMutableArray *)views {
    if (!_views) {
        _views = [[NSMutableArray alloc] init];
        
        NSArray<NSArray *> *image = @[
                                      @[@"明细",@"图表",@"记账",@"发现",@"我的"],
                                      @[@"tabbar_detail_n",
                                        @"tabbar_chart_n",
                                        @"tabbar_add_n",
                                        @"tabbar_discover_n",
                                        @"tabbar_mine_n"],
                                      @[@"tabbar_detail_s",
                                        @"tabbar_chart_s",
                                        @"tabbar_add_h",
                                        @"tabbar_discover_s",
                                        @"tabbar_mine_s"]
                                      ];
        NSInteger current = 0;
        NSInteger count = [image[0] count];
        for (int i=0; i<count; i++) {
            CGFloat width = SCREEN_WIDTH / count;
            UIImageView *icon = ({
                UIImageView *icon = [[UIImageView alloc] initWithFrame:({
                    CGRect frame;
                    if (i != 2) {
                        frame = CGRectMake((width - 23) / 2, 7, 23, 23);
                    }
                    else {
                        frame = CGRectMake(0, 0, width, 60);
                    }
                    frame;
                })];
                icon.image = [UIImage imageNamed:current == i ? image[2][i] : image[1][i]];
                icon.contentMode = UIViewContentModeScaleAspectFit;
                icon.tag = 10;
                icon;
            });
            
            UILabel *lab = ({
                UILabel *lab = [[UILabel alloc] initWithFrame:({
                    CGRectMake(0, CGRectGetMaxY(icon.frame) + 1, width, 15);
                })];
                lab.text = image[0][i];
                lab.font = [UIFont boldSystemFontOfSize:AdjustFont(8)];
                lab.textColor = current == i ? kColor_Text_Gary : kColor_Text_Gary;
                lab.textAlignment = NSTextAlignmentCenter;
                lab.tag = 11;
                lab;
            });
            
            UIView *item = ({
                UIView *item = [[UIView alloc] initWithFrame:({
                    CGFloat left = width * i;
                    CGRect frame;
                    if (i != 2) {
                        frame = CGRectMake(left, 0, width, TabbarHeight);
                    }
                    else {
                        frame = CGRectMake(left, -30, width, TabbarHeight + 30);
                    }
                    frame;
                })];
                [item addSubview:icon];
                [item addSubview:lab];
                item;
            });
            [self addSubview:item];
            [_views addObject:item];
            
            __weak typeof(self) weak = self;
            [item addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                if (weak.click) {
                    weak.click(i);
                }
            }];
        }
    }
    return _views;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
