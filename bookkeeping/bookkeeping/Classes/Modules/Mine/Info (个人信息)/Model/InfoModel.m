//
//  InfoModel.m
//  bookkeeping
//
//  Created by 郑业强 on 2018/12/24.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

+ (void)load {
    [InfoModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id",
                 };
    }];
}

@end
