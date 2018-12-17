//
//  NSString+Extension.h
//  iOS
//
//  Created by RY on 2018/3/20.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGSize)sizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font;
- (CGSize)sizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font lineHeight:(CGFloat)lineHeight;


- (CGSize)sizeWithAttrMaxSize:(CGSize)maxSize font:(UIFont *)font;
- (CGSize)sizeWithAttrMaxSize:(CGSize)maxSize font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;



// 中文转拼音
+ (NSString *)transform:(NSString *)chinese ;
// 10000 转 1万
+ (NSString *)getMeasureThousand:(NSInteger)math;



@end
