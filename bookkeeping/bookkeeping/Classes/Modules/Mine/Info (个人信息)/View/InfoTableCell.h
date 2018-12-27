/**
 * cell
 * @author 郑业强 2018-12-22 创建文件
 */

#import "BaseTableCell.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - NS_ENUM
typedef NS_ENUM(NSUInteger, InfoTableCellStatus) {
    InfoTableCellStatusNext,
    InfoTableCellStatusName,
    InfoTableCellStatusIcon,
};

#pragma mark - 声明
@interface InfoTableCell : BaseTableCell

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) InfoTableCellStatus status;
@property (nonatomic, strong) UserModel *model;

@end

NS_ASSUME_NONNULL_END
