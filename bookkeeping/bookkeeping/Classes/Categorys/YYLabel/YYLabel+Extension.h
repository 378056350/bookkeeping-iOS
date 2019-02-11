//
//  YYLabel+Extension.h
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/3.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <YYText/YYText.h>
#import <YYImage/YYImage.h>

#define YY_MaxSize      @"YY_MaxSize"
#define YY_String       @"YY_String"
#define YY_Icon         @"YY_Icon"
#define YY_LineSpacing  @"YY_LineSpacing"
#define YY_Font         @"YY_Font"
#define YY_ImageFrame   @"YY_ImageFrame"

NS_ASSUME_NONNULL_BEGIN

@interface YYLabel (Extension)

- (void)createLabWithParam:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
