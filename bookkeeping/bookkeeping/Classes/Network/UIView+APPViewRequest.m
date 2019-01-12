//
//  UIView+APPViewRequest.m
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/27.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UIView+APPViewRequest.h"

static void *kUIView_APPViewRequest;

@implementation UIView (APPViewRequest)


#pragma mark - get
- (APPViewRequest *)afn_sharedManager {
    APPViewRequest *request = [APPViewRequest sharedManager];
    request.afn_frame = self.bounds;
    request.view = self;
    return request;
}


#pragma mark - 功能
// 参数
- (NSDictionary *)createParams:(NSDictionary *)param
                 viewParameter:(APPViewRequest *)viewParameter {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    if (viewParameter && viewParameter.page >= 0) {
        [params setValue:@(viewParameter.page) forKey:@"page"];
    }
    return params;
}
// 停止刷新
- (void)endRefresh {
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scroll = (UIScrollView *)self;
        [scroll.mj_header endRefreshing];
        [scroll.mj_footer endRefreshing];
    }
}
// 临时缓存
- (void)useMemoryCache:(NSString *)url complete:(AFNManagerCompleteBlock)complete {
    if (complete) {
        id responseObject = [NSUserDefaults objectForKey:url];
        APPResult *result = [[APPResult alloc] init];
        result.code = ServiceCodeMemoryCache;
        result.status = ServiceCodeSuccess;
        result.data = responseObject;
        result.message = @"读取缓存成功";
        complete(result);
    }
}
// 本地缓存
- (void)useDiskCache:(NSString *)url complete:(AFNManagerCompleteBlock)complete {
    if (complete) {
        id responseObject = [NSUserDefaults objectForKey:url];
        APPResult *result = [[APPResult alloc] init];
        result.code = ServiceCodeMemoryCache;
        result.status = ServiceCodeSuccess;
        result.data = responseObject;
        result.message = @"读取缓存成功";
        complete(result);
    }
}
// 失败回调
- (void)createErrorBlock:(AFNManagerCompleteBlock)complete {
    // 回调
    if (complete) {
        APPResult *result = [[APPResult alloc] init];
        result.data = nil;
        result.code = ServiceCodeFail;
        result.status = ServiceStatusFail;
        result.message = @"请求失败";
        complete(result);
    }
}


#pragma mark - 请求
- (void)createRequest:(NSString *)url
               params:(NSDictionary * _Nullable )params
             complete:(AFNManagerCompleteBlock)complete {
    [self createRequest:url params:params progress:nil complete:complete];
}
- (void)createRequest:(NSString *)url
               params:(NSDictionary * _Nullable )params
             progress:(AFNManagerProgressBlock)progress
             complete:(AFNManagerCompleteBlock)complete {
    APPViewRequest *viewParameter = [self afn_request];
    
    // 刷新
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scroll = (UIScrollView *)self;
        __weak typeof(self) weak = self;
        
        [scroll.mj_header setRefreshingBlock:^{
            [viewParameter setAfn_isHeader:YES];
            [weak createRequest:url params:params progress:progress complete:complete];
        }];
        [scroll.mj_footer setRefreshingBlock:^{
            [viewParameter setAfn_isHeader:NO];
            [weak createRequest:url params:params progress:progress complete:complete];
        }];
    }
    // 配置
    if (viewParameter) {
        // 显示等待页 && 无数据
        if ([viewParameter afn_showLoading] == YES && [viewParameter afn_hasData] == NO) {
            [viewParameter.view showEmpty:viewParameter.afn_loadStatus frame:viewParameter.afn_frame hasBack:viewParameter.afn_hasBack];
        }
        // 使用缓存
        if ([viewParameter afn_useCache] == YES) {
//            // 临时缓存
//            if ([[PINMemoryCache sharedCache] containsObjectForKey:url]) {
//                [viewParameter.view hideEmpty];
//                [self useMemoryCache:url complete:complete];
//            }
//            // 本地缓存
//            else if ([[PINCacheManager sharedManager] containsObjectForKey:url]) {
//                [viewParameter.view hideEmpty];
//                [self useDiskCache:url complete:complete];
//            }
        }
    }
    // 请求
    __weak typeof(self) weak = self;
    NSDictionary *param = [self createParams:params viewParameter:viewParameter];
    [AFNManager POST:url params:param progress:^(CGFloat currentProgress, CGFloat maxProgress, CGFloat percentage) {
        // 过程
        if (progress) {
            progress(currentProgress, maxProgress, percentage);
        }
    } complete:^(APPResult * _Nonnull result) {
        // 停止刷新
        [weak endRefresh];
        // 成功
        if (result.status == ServiceStatusSuccess) {
            // 有数据
            [viewParameter setAfn_hasData:YES];
            // 隐藏等待页
            [viewParameter.view hideEmpty];
            // 存储数据
            if (viewParameter.afn_isHeader == YES) {
                [viewParameter setResult:result];
                [viewParameter setPage:0];
                result = viewParameter.result;
            } else {
                NSMutableArray *arrm = [NSMutableArray arrayWithArray:viewParameter.result.data];
                [arrm addObjectsFromArray:result.data];
                [viewParameter.result setData:arrm];
                [viewParameter setPage:viewParameter.page + 1];
                result = viewParameter.result;
            }
            // 解析
            complete(result);
            // 本地缓存
//            [NSUserDefaults setObjectAsync:result.data forKey:url completion:nil];
            // 临时缓存
//            [[PINMemoryCache sharedCache] setObjectAsync:result.data forKey:url completion:nil];
        }
        // 失败
        else if (result.status == ServiceStatusFail) {
            // 使用缓存
            if (viewParameter && viewParameter.afn_useCache == YES) {
                // 隐藏
                [viewParameter.view hideEmpty];
//                // 临时缓存
//                if ([[PINMemoryCache sharedCache] containsObjectForKey:url]) {
//                    [weak useMemoryCache:url complete:complete];
//                }
//                // 本地缓存
//                else if ([[PINCacheManager sharedManager] containsObjectForKey:url]) {
//                    [weak useDiskCache:url complete:complete];
//                }
//                // 失败
//                else {
                    // 回调
                    [weak createErrorBlock:complete];
                    // 错误页
                    if (viewParameter.afn_showError == YES) {
                        [viewParameter.view showEmpty:viewParameter.afn_errorStatus frame:viewParameter.afn_frame hasBack:viewParameter.afn_hasBack complete:^(KKEmptyClickDeal deal) {
                            if (viewParameter.afn_showLoading == YES) {
                                [viewParameter.view showEmpty:viewParameter.afn_loadStatus frame:viewParameter.afn_frame hasBack:viewParameter.afn_hasBack];
                            }
                            [self createRequest:url params:params complete:complete];
                        }];
                    }
//                }
            }
            // 失败
            else {
                // 回调
                [weak createErrorBlock:complete];
                // 错误页
                if (viewParameter.afn_showError == YES) {
                    [viewParameter.view showEmpty:viewParameter.afn_errorStatus frame:viewParameter.afn_frame hasBack:viewParameter.afn_hasBack complete:^(KKEmptyClickDeal deal) {
                        if (viewParameter.afn_showLoading == YES) {
                            [viewParameter.view showEmpty:viewParameter.afn_loadStatus frame:viewParameter.afn_frame hasBack:viewParameter.afn_hasBack];
                        }
                        [self createRequest:url params:params complete:complete];
                    }];
                }
            }
        }
    }];
    
}


#pragma mark - runtime
- (void)setAfn_request:(APPViewRequest *)afn_request {
    objc_setAssociatedObject(self, &kUIView_APPViewRequest, afn_request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (APPViewRequest *)afn_request {
    if (!objc_getAssociatedObject(self, &kUIView_APPViewRequest)) {
        APPViewRequest *req = [self afn_sharedManager];
        [self setAfn_request:req];
    }
    return objc_getAssociatedObject(self, &kUIView_APPViewRequest);
}



@end
