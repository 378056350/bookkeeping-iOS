/**
 * item
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseCollectionCell.h"
#import "ChartSubModel.h"

#define LAB_FONT [UIFont fontWithName:@"Helvetica Neue" size:AdjustFont(12)]

NS_ASSUME_NONNULL_BEGIN

@interface ChartDateCell : BaseCollectionCell

@property (nonatomic, strong) ChartSubModel *model;
@property (nonatomic, assign) BOOL choose;

@end

NS_ASSUME_NONNULL_END
