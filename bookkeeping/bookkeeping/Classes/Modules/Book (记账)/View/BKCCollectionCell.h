/**
 * 列表Cell
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BaseCollectionCell.h"
#import "BKCIncomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BKCCollectionCell : BaseCollectionCell

@property (nonatomic, strong) BKCModel *model;
@property (nonatomic, assign, getter=isChoose) BOOL choose;

@end

NS_ASSUME_NONNULL_END
