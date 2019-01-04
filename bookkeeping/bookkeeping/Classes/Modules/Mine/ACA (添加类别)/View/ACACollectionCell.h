/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseCollectionCell.h"
#import "ACAListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACACollectionCell : BaseCollectionCell

@property (nonatomic, strong) ACAModel *model;
@property (nonatomic, assign) BOOL choose;

@end

NS_ASSUME_NONNULL_END
