/**
 * 图表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"
#import "ChartModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ENUM
typedef NS_ENUM(NSInteger, BookChartStatus) {
    BookChartStatusWeek,        // 周
    BookChartStatusMonth,       // 月
    BookChartStatusYear,        // 年
};


#pragma mark - 声明
@interface BookChart : BaseView

@property (nonatomic, strong) NSMutableArray<ChartModel *> *models;
@property (nonatomic, assign) BookChartStatus status;

@end

NS_ASSUME_NONNULL_END
