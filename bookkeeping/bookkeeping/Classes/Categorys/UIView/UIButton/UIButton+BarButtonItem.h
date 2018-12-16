//
//  UIButton+BarButtonItem.h
//  imiss
//
//  Created by MAC on 2018/8/15.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BarButtonItem)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
