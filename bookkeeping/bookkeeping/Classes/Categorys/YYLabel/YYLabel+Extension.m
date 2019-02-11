//
//  YYLabel+Extension.m
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/3.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "YYLabel+Extension.h"

@implementation YYLabel (Extension)


- (void)createLabWithParam:(NSDictionary *)param {
    CGSize maxSize      = [param[YY_MaxSize] CGSizeValue];
    NSString *str       = param[YY_String];
    NSString *icn       = param[YY_Icon];
    CGFloat lineSpacing = [param[YY_LineSpacing] floatValue];
    UIFont *font        = param[YY_Font];
    CGRect imageFrame   = [param[YY_ImageFrame] CGRectValue];
    
    self.numberOfLines = 0;
    self.preferredMaxLayoutWidth = maxSize.width;
    self.attributedText = ({
        NSDictionary *dict = @{NSFontAttributeName: font,
                               NSForegroundColorAttributeName: kColor_Text_Black};
        NSMutableAttributedString *attachText1 = ({
            YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:[UIImage imageNamed:icn]];
            imageView.frame = imageFrame;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            NSMutableAttributedString *attachText1 = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView.frame.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            attachText1;
        });
        attachText1.yy_lineSpacing = lineSpacing;
        
        NSString *strm = [NSString stringWithFormat:@" %@", str];
        NSMutableAttributedString *attrim = [[NSMutableAttributedString alloc] initWithString:strm attributes:dict];
        [attrim insertAttributedString:attachText1 atIndex:0];
        attrim;
    });
    
    
    //计算文本尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:self.attributedText];
    self.textLayout = layout;
    
    CGFloat introHeight = layout.textBoundingSize.height;
    
    self.origin = CGPointZero;
    self.height = introHeight;
    self.width = maxSize.width;
}


@end
