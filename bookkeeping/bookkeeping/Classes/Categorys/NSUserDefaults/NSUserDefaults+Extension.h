/**
 * 存储管理
 * @author 郑业强 2019-01-12 创建文件
 */

#import <Foundation/Foundation.h>
#import "BKModel.h"
#import "CategoryListModel.h"
#import "ACAListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Extension)

// 取值
+ (id)objectForKey:(NSString *)key;
// 存值
+ (void)setObject:(id)obj forKey:(NSString *)key;


// 删除记账
+ (void)removeBookModel:(BKModel *)model;
// 添加记账
+ (void)insertBookModel:(BKModel *)model;
// 修改记账
+ (void)replaceBookModel:(BKModel *)model;


// 添加分类
+ (void)insertCategoryModel:(BKCModel *)model is_income:(BOOL)is_income;
// 删除分类
+ (void)removeCategoryModel:(BKCModel *)model is_income:(BOOL)is_income;
// 获取分类
+ (NSMutableArray *)getCategoryModel;


@end

NS_ASSUME_NONNULL_END
