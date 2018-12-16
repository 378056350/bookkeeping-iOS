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
    [self setShadowLine:[kColor_Text_Gary colorWithAlphaComponent:0.1]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //            [obj removeFromSuperview];
            [obj setAlpha:0];
        }
    }
    
    
    [self views];
}



- (void)click:(NSInteger)index {
    NSArray<NSArray *> *image = @[
                                  @[@"明细",@"图表",@"记账",@"发现",@"我的"],
                                  @[@"cm4_btm_icn_discovery",
                                    @"cm4_btm_icn_music_new",
                                    @"cm4_btm_icn_account",
                                    @"cm4_btm_icn_account",
                                    @"cm4_btm_icn_account"],
                                  @[@"cm4_btm_icn_discovery_prs",
                                    @"cm4_btm_icn_music_new_prs",
                                    @"cm4_btm_icn_account_prs",
                                    @"cm4_btm_icn_account_prs",
                                    @"cm4_btm_icn_account_prs"]
                                  ];
    
    for (int y=0; y<self.views.count; y++) {
        UIView *subview = self.views[y];
        UIImageView *subicon = [subview viewWithTag:10];
        subicon.image = [UIImage imageNamed:y == index ? image[2][y] : image[1][y]];
        UILabel *sublab = [subview viewWithTag:11];
        sublab.textColor = y == index ? MainColor : kColor_Text_Gary;
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
- (void)setIndex:(NSInteger)index {
    _index = index;
    [self click:index];
//    if (self.click) {
//        self.click(index);
//    }
}


#pragma mark - get
- (NSMutableArray *)views {
    if (!_views) {
        _views = [[NSMutableArray alloc] init];
        
        NSArray<NSArray *> *image = @[
                                      @[@"明细",@"图表",@"记账",@"发现",@"我的"],
                                      @[@"cm4_btm_icn_discovery",
                                        @"cm4_btm_icn_music_new",
                                        @"cm4_btm_icn_account",
                                        @"cm4_btm_icn_account",
                                        @"cm4_btm_icn_account"],
                                      @[@"cm4_btm_icn_discovery_prs",
                                        @"cm4_btm_icn_music_new_prs",
                                        @"cm4_btm_icn_account_prs",
                                        @"cm4_btm_icn_account_prs",
                                        @"cm4_btm_icn_account_prs"]
                                      ];
        NSInteger current = 0;
        NSInteger count = [image[0] count];
        for (int i=0; i<count; i++) {
            CGFloat width = SCREEN_WIDTH / count;
            UIImageView *icon = ({
                UIImageView *icon = [[UIImageView alloc] initWithFrame:({
                    CGRectMake((width - 22) / 2, (49 - 30) / 2, 22, 20);
                })];
                icon.image = [UIImage imageNamed:current == i ? image[2][i] : image[1][i]];
                icon.contentMode = UIViewContentModeScaleAspectFit;
                icon.tag = 10;
                icon;
            });
            
            UILabel *lab = ({
                UILabel *lab = [[UILabel alloc] initWithFrame:({
                    CGRectMake(0, CGRectGetMaxY(icon.frame), width, 15);
                })];
                lab.text = image[0][i];
                lab.font = [UIFont systemFontOfSize:AdjustFont(9)];
                lab.textColor = current == i ? MainColor : kColor_Text_Gary;
                lab.textAlignment = NSTextAlignmentCenter;
                lab.tag = 11;
                lab;
            });
            
            UIView *item = ({
                UIView *item = [[UIView alloc] initWithFrame:({
                    CGFloat left = width * i;
                    CGRectMake(left, 0, width, TabbarHeight);
                })];
                [item addSubview:icon];
                [item addSubview:lab];
                [item setBackgroundColor:kColor_White];
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
