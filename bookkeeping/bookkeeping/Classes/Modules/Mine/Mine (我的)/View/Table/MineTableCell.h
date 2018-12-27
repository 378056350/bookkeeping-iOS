/**
 * 我的列表Cell
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BaseTableCell.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - NS_ENUM
typedef NS_ENUM(NSUInteger, MineTableCellStatus) {
    MineTableCellStatusText,
    MineTableCellStatusSw,
};


#pragma mark - 声明
@interface MineTableCell : BaseTableCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UISwitch *sw;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIImageView *nextIcn;
@property (nonatomic, assign) MineTableCellStatus status;
@property (nonatomic, assign) NSInteger badgeCount;

@end

NS_ASSUME_NONNULL_END
