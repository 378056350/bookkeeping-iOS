//
//  BaseTabBar.h
//  weibo-OC
//
//  Created by Oboe_b on 16/8/29.
//  Copyright © 2016年 Oboe_b. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - typedef
typedef void (^BaseTabBarClick)(NSInteger index);

#pragma mark - 声明
@interface BaseTabBar : UITabBar

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy  ) BaseTabBarClick click;

@end
