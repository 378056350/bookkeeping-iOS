/**
 * 归档
 * @author 郑业强 2019-01-04 创建文件
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NSCoding)

+ (id)decodeClass:(id)object decoder:(NSCoder *)aDecoder;
+ (void)encodeClass:(id)object encoder:(NSCoder *)aCoder;

@end

NS_ASSUME_NONNULL_END
