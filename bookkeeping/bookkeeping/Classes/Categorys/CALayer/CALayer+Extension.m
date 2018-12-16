//
//  CALayer+Extension.m
//  imiss
//
//  Created by MAC on 2018/8/15.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

- (UIImage *)imageFromView {
    CGSize size = self.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return image;
}

@end
