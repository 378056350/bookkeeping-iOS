/**
 * 本地数据管理
 * @author 郑业强 2010-01-03 创建文件
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PINCacheManager : NSObject


+ (PINDiskCache *)sharedManager;

/** 初始化配置 */
+ (void)pinCacheManager;

@end

NS_ASSUME_NONNULL_END
