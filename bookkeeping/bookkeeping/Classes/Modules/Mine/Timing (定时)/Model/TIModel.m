//
//  TIModel.m
//  bookkeeping
//
//  Created by zhongke on 2018/12/27.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "TIModel.h"

@implementation TIModel

+ (void)load {
    [TIModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id"
                 };
    }];
}

@end
