/**
 * 图表
 * @author 郑业强 2018-12-17 创建文件
 */


#import "BaseView.h"
#import "ChartSubModel.h"
#import "ChartRangeModel.h"
#import "BKModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - typedef
typedef void (^ChartDateComplete)(ChartSubModel *model);


#pragma mark - 声明
@interface ChartDate : BaseView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, strong) NSIndexPath *selectIndex;
@property (nonatomic, strong) NSMutableArray<ChartSubModel *> *subModels;
@property (nonatomic, copy  ) ChartDateComplete complete;
@property (nonatomic, strong) ChartRangeModel *timeModel;
@property (nonatomic, strong) BKModel *model;

@end

NS_ASSUME_NONNULL_END
