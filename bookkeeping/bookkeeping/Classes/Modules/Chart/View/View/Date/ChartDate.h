/**
 * 图表
 * @author 郑业强 2018-12-17 创建文件
 */


#import "BaseView.h"
#import "ChartModel.h"
#import "ChartRangeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartDate : BaseView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray<ChartModel *> *models;
@property (nonatomic, strong) ChartRangeModel *timeModel;

@end

NS_ASSUME_NONNULL_END
