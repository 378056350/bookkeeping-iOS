/**
 * 列表Cell
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BaseCollectionCell.h"
#import "BookListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookCollectionCell : BaseCollectionCell

@property (nonatomic, strong) BookModel *model;
@property (nonatomic, assign, getter=isChoose) BOOL choose;

@end

NS_ASSUME_NONNULL_END
