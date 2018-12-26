//
//  KKSocialUserInfoResponse.h
//  bookkeeping
//
//  Created by zhongke on 2018/12/25.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UMShare/UMShare.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKSocialUserInfoResponse : UMSocialUserInfoResponse

@property (nonatomic, strong) UIImage *icon;

+ (KKSocialUserInfoResponse *)create:(UMSocialUserInfoResponse *)resp;

@end

NS_ASSUME_NONNULL_END
