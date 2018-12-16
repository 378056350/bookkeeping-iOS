//
//  UIImage+Extension.m
//  imiss
//
//  Created by MAC on 2018/9/21.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

@end


@implementation UIImage (Filter)

/// 高斯模糊
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                        
                                  keysAndValues:kCIInputImageKey, inputImage,
                        
                        @"inputRadius", @(blur), nil];
    
    CIImage *outputImage = filter.outputImage;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
    
    return [UIImage imageWithCGImage:outImage];
    
}

@end
