//
//  NSString+Extension.m
//  iOS
//
//  Created by RY on 2018/3/20.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (CGSize)sizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
}
- (CGSize)sizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font lineHeight:(CGFloat)lineHeight {
    if (!self || self.length == 0) {
        return CGSizeMake(maxSize.width, 0);
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    paraStyle.lineSpacing = lineHeight;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self
                                                                                       attributes:@{NSParagraphStyleAttributeName: paraStyle,NSFontAttributeName: font}];
    
    CGRect rect = [attributeString boundingRectWithSize:maxSize
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                context:nil];
    
    if ((rect.size.height - font.lineHeight) <= lineHeight) {
        if ([self containChinese:self]) {
            rect.size.height -= lineHeight;
        }
    }
    
    return CGSizeMake(maxSize.width, rect.size.height);
}


// 判断是否包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}



- (CGSize)sizeWithAttrMaxSize:(CGSize)maxSize font:(UIFont *)font {
    return [self sizeWithAttrMaxSize:maxSize font:font lineSpacing:0];
}
- (CGSize)sizeWithAttrMaxSize:(CGSize)maxSize font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    
    NSDictionary *param = @{NSFontAttributeName: font,
                            NSParagraphStyleAttributeName: style
                            };
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self attributes:param];
    CGSize size = [attr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return size;
}


// 中文转拼音
+ (NSString *)transform:(NSString *)chinese {
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //    NSLog(@"%@", pinyin);
    
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //    NSLog(@"%@", pinyin);
    
    //返回最近结果
    return pinyin;
    
}
// 1000 转 1k
+ (NSString *)getMeasureThousand:(NSInteger)math {
    if (math / 1000 != 0) {
        return [NSString stringWithFormat:@"%ldk", math / 1000];
    }
    return [@(math) description];
}


@end
