//
//  BaseTabBarController.h
//  iOS
//
//  Created by RY on 2018/3/19.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

@property (nonatomic, assign) NSInteger index;

- (void)hideTabbar:(BOOL)hidden;

@end
