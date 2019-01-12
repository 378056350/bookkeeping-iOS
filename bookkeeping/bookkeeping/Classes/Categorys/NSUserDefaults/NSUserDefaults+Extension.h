/**
 * 存储管理
 * @author 郑业强 2019-01-12 创建文件
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Extension)

// 取值
+ (id)objectForKey:(NSString *)key;
// 存值
+ (void)setObject:(id)obj forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
