/**
 * 请求结果
 * @author 郑业强 2018-10-
 */

#import <Foundation/Foundation.h>

#pragma mark - typeof
typedef NS_ENUM(NSInteger, ServiceCode) {
    ServiceCodeSuccess = 200,       // 成功
    ServiceCodeDiskCache = 201,     // 硬盘缓存
    ServiceCodeMemoryCache = 202,   // 内存缓存
    ServiceCodeFail = 1001,         // 失败
};

typedef NS_ENUM(NSInteger, ServiceStatus) {
    ServiceStatusSuccess = 200,       // 成功
    ServiceStatusFail = 1001,         // 失败
};

@interface APPResult : NSObject

@property (nonatomic, assign) ServiceCode code;     // 错误码
@property (nonatomic, assign) ServiceStatus status; // 样式
@property (nonatomic, strong) id data;              // 数据
@property (nonatomic, strong) id message;           // 描述

@end
