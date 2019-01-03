//
//  UserModel.m
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/9.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (void)load {
    [UserModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id"
                 };
    }];
}

- (NSString *)punchCount {
    return _punchCount ? _punchCount : @"0";
}


@end
