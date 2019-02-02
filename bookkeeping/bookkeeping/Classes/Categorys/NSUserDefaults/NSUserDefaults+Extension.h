/**
 * 存储管理
 * @author 郑业强 2019-01-12 创建文件
 */

#import <Foundation/Foundation.h>
#import "BKModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Extension)

// 取值
+ (id)objectForKey:(NSString *)key;
// 存值
+ (void)setObject:(id)obj forKey:(NSString *)key;

// 删除记账
+ (void)removeBookModel:(BKModel *)model;

@end

NS_ASSUME_NONNULL_END
