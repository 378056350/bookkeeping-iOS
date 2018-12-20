//
//  NSAttributedString+Extension.m
//  music
//
//  Created by MAC on 2018/9/26.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

// 创建带阴影的富文本
+ (NSAttributedString *)shadowAttrString:(NSString *)string
                                   color:(UIColor *)color
                                fontSize:(NSInteger)fontSize
                               alignment:(NSTextAlignment)alignment {
    // 居中样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = alignment;
    
    // 阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 1.5;
    shadow.shadowOffset = CGSizeMake(0, 0);
    shadow.shadowColor = color;
    
    
    
    // 参数
    NSDictionary *param = @{NSShadowAttributeName: shadow,
                            NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                            NSParagraphStyleAttributeName: style,
                            NSForegroundColorAttributeName: color
                            };
    
    // 富文本
    NSAttributedString *attrm = [[NSAttributedString alloc] initWithString:string attributes:param];
    return attrm;
}

// 带行高的富文本
+ (NSAttributedString *)attriString:(NSString *)string
                              color:(UIColor *)color
                               font:(UIFont *)font
                         lineHeight:(CGFloat)lineHeight {
    // 设置段落
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineHeight;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: color,
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 };
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    return attriStr;
}


// 数字, 整数和小数字体不一样
+ (NSAttributedString *)createMath:(NSString *)string
                           integer:(UIFont *)integerFont
                           decimal:(UIFont *)decimalFont {
    return [self createMath:string integer:integerFont decimal:decimalFont color:kColor_Text_Black];
}

+ (NSAttributedString *)createMath:(NSString *)string
                           integer:(UIFont *)integerFont
                           decimal:(UIFont *)decimalFont
                             color:(UIColor *)color {
    
    NSString *integerStr = [NSString stringWithFormat:@"%@.", [string componentsSeparatedByString:@"."][0]];
    NSString *decimalStr = [string componentsSeparatedByString:@"."][1];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:integerStr attributes:@{NSFontAttributeName: integerFont, NSForegroundColorAttributeName: color}];
    NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:decimalStr attributes:@{NSFontAttributeName: decimalFont, NSForegroundColorAttributeName: color}];
    NSMutableAttributedString *attrm = [[NSMutableAttributedString alloc] initWithAttributedString:attr1];
    [attrm appendAttributedString:attr2];
    return attrm;
}


@end
