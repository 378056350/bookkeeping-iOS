/**
 * 图表头视图
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"
#import "ChartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartTableHeader : BaseView

@property (nonatomic, strong) NSMutableArray<ChartModel *> *models;

@end

NS_ASSUME_NONNULL_END
