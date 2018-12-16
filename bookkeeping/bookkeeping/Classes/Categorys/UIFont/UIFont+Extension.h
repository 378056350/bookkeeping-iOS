//
//  UIFont+Extension.h
//  iOS
//
//  Created by RY on 2018/3/23.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IPHONE6_INCREMENT 2
#define IPHONE6PLUS_INCREMENT 3
#define IPHONE6PLUS_UP_INCREMENT 4
#define IS_IPHONEX_INCREMENT 4

@interface UIFont (Extension)

/// 自适应字体大小
+ (CGFloat)adjustFontSize:(CGFloat)fontsize;

@end
