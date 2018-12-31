/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseTableCell.h"
#import "CategoryListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCell : MGSwipeTableCell

@property (nonatomic, strong) BKCModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
