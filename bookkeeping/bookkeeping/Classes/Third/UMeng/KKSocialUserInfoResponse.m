//
//  KKSocialUserInfoResponse.m
//  bookkeeping
//
//  Created by zhongke on 2018/12/25.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "KKSocialUserInfoResponse.h"

@implementation KKSocialUserInfoResponse

+ (KKSocialUserInfoResponse *)create:(UMSocialUserInfoResponse *)resp {
    KKSocialUserInfoResponse *kk = [[KKSocialUserInfoResponse alloc] init];
    kk.name = resp.name;
    kk.openid = resp.openid;
    kk.iconurl = resp.iconurl;
    kk.unionGender = resp.unionGender;
    kk.gender = resp.gender;
    return kk;
}

@end
