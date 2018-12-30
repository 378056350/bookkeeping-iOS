/**
 * 图表
 * @author 郑业强 2018-12-17 创建文件
 */


#import "BaseView.h"
#import "ChartModel.h"
#import "ChartSubModel.h"
#import "ChartRangeModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - typedef
typedef void (^ChartDateComplete)(ChartSubModel *model);


#pragma mark - 声明
@interface ChartDate : BaseView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, strong) NSIndexPath *selectIndex;
@property (nonatomic, strong) NSMutableArray<ChartModel *> *groupModels;
@property (nonatomic, strong) NSMutableArray<ChartSubModel *> *subModels;
@property (nonatomic, strong) ChartRangeModel *timeModel;
@property (nonatomic, copy  ) ChartDateComplete complete;

@end

NS_ASSUME_NONNULL_END
