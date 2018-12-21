/**
 * 类别设置
 * @author 郑业强 2018-12-21 创建文件
 */

#import "BaseModel.h"
#import "BookListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryListModel : BaseModel

@property (nonatomic, assign) BOOL is_income;
@property (nonatomic, strong) NSArray<BookModel *> *insert;
@property (nonatomic, strong) NSArray<BookModel *> *remove;

@end

NS_ASSUME_NONNULL_END
