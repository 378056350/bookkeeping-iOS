//
//  UIImage+Extension.h
//  imiss
//
//  Created by MAC on 2018/9/21.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

@end

@interface UIImage (Filter)

/// 高斯模糊
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
