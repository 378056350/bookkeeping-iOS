//
//  NSAttributedString+Extension.h
//  music
//
//  Created by MAC on 2018/9/26.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)

// 创建带阴影的富文本
+ (NSAttributedString *)shadowAttrString:(NSString *)string
                                   color:(UIColor *)color
                                fontSize:(NSInteger)fontSize
                               alignment:(NSTextAlignment)alignment;

// 带行高的富文本
+ (NSAttributedString *)attriString:(NSString *)string
                              color:(UIColor *)color
                               font:(UIFont *)font
                         lineHeight:(CGFloat)lineHeight;

// 数字, 整数和小数字体不一样
+ (NSAttributedString *)createMath:(NSString *)string
                           integer:(UIFont *)integerFont
                           decimal:(UIFont *)decimalFont;

+ (NSAttributedString *)createMath:(NSString *)string
                           integer:(UIFont *)integerFont
                           decimal:(UIFont *)decimalFont
                             color:(UIColor *)color;


@end
