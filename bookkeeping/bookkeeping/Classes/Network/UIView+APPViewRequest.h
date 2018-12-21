//
//  UIView+APPViewRequest.h
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/27.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APPViewRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (APPViewRequest)

@property (nonatomic, strong) APPViewRequest *afn_request;

- (void)createRequest:(NSString *)url
               params:(NSDictionary * _Nullable )params
             complete:(AFNManagerCompleteBlock)complete;
- (void)createRequest:(NSString *)url
               params:(NSDictionary * _Nullable )params
             progress:(AFNManagerProgressBlock)progress
             complete:(AFNManagerCompleteBlock)complete;

@end

NS_ASSUME_NONNULL_END
