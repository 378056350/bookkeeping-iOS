/**
 * 图片
 * @author 郑业强 2019-02-04
 */

#import "BaseTableCell.h"
#import "CCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCIconCell : BaseTableCell

@property (nonatomic, strong) CCModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (CGFloat)getCellHeight:(CCModel *)model;

@end

NS_ASSUME_NONNULL_END
