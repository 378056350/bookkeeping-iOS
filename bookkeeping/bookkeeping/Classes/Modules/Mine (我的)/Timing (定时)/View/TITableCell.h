/**
 * 定时
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseTableCell.h"
//#import "TIModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TITableCell : MGSwipeTableCell

@property (nonatomic, strong) NSIndexPath *indexPath;
//@property (nonatomic, strong) TIModel *model;
@property (nonatomic, strong) NSString *time;

@end

NS_ASSUME_NONNULL_END
