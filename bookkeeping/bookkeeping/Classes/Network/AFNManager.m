//
//  AFNManager.m
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/27.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "AFNManager.h"
#import <AFNetworking/AFNetworking.h>

#pragma mark - 声明
@interface AFNManager()

@end


#pragma mark - 实现
@implementation AFNManager

static AFHTTPSessionManager *_manager;


#pragma mark - get
+ (AFHTTPSessionManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}


#pragma mark - 请求
+ (void)POST:(NSString *)url complete:(AFNManagerCompleteBlock)complete {
    [self POST:url params:nil complete:complete];
}
+ (void)POST:(NSString *)url params:(NSDictionary *)params complete:(AFNManagerCompleteBlock)complete {
    [self POST:url params:params progress:nil complete:complete];
}
+ (void)POST:(NSString *)url params:(NSDictionary *)params progress:(AFNManagerProgressBlock)progress complete:(AFNManagerCompleteBlock)complete {
    
    AFHTTPSessionManager *manager = [AFNManager manager];
    if ([UserInfo isLogin]) {
        [manager.requestSerializer setValue:[UserInfo loadUserInfo].token forHTTPHeaderField:@"token"];
    }
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        // 过程
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount, downloadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功
        if (complete) {
            // 解析
            APPResult *result = [APPResult mj_objectWithKeyValues:responseObject];
            result.code = ServiceCodeSuccess;
            complete(result);
//            // 存储Token
//            if (result.data &&
//                [result.data isKindOfClass:[NSDictionary class]] &&
//                [[result.data allKeys] containsObject:@"token"]) {
//                [UserInfo saveToken:result.data[@"token"]];
//            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        // 回调
        if (complete) {
            APPResult *result = [[APPResult alloc] init];
            result.data = nil;
            result.code = ServiceCodeFail;
            result.status = ServiceStatusFail;
            result.message = @"请求失败";
            complete(result);
        }
    }];
}
+ (void)POST:(NSString *)url params:(NSDictionary *)params andImages:(NSArray<UIImage *> *)images progress:(AFNManagerProgressBlock)progress complete:(AFNManagerCompleteBlock)complete {
    AFHTTPSessionManager *manager = [self manager];
    // Token
    if ([UserInfo loadUserInfo]) {
        [manager.requestSerializer setValue:[UserInfo loadUserInfo].token forHTTPHeaderField:@"token"];
    }
    // 请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 图片
        if (images && [images count] > 0) {
            for (NSInteger index = 0; index < images.count; index++) {
                // 图片转数据
                NSString *imgName = [NSString stringWithFormat:@"image%ld", index];
                NSData *data = UIImagePNGRepresentation(images[index]);
                if (data == nil) {
                    data = UIImageJPEGRepresentation(images[index], 1.0);
                }
                // 添加参数
                [formData appendPartWithFileData:data name:@"file" fileName:imgName mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 过程
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount, uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回调
        if (complete) {
            APPResult *result = [APPResult mj_objectWithKeyValues:responseObject];
            result.code = ServiceCodeSuccess;
            complete(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 回调
        if (complete) {
            APPResult *result = [[APPResult alloc] init];
            result.data = nil;
            result.code = ServiceCodeFail;
            result.status = ServiceStatusFail;
            result.message = @"请求失败";
            complete(result);
        }
    }];
}


@end
