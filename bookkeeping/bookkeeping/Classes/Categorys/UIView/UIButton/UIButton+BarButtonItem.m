//
//  UIButton+BarButtonItem.m
//  imiss
//
//  Created by MAC on 2018/8/15.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UIButton+BarButtonItem.h"

@implementation UIButton (BarButtonItem)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
