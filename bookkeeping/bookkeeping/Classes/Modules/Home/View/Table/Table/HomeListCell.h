/**
 * 列表cell
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseTableCell.h"
#import "HomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeListCell : BaseTableCell

@property (nonatomic, strong) NSMutableArray<NSMutableArray<HomeListModel *> *> *models;

- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
