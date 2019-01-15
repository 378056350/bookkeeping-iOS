/**
 * 图表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"
#import "BKModel.h"
#import "ChartSubModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 声明
@interface BookChart : BaseView

@property (nonatomic, strong) BKChartModel *model;

@end

NS_ASSUME_NONNULL_END
