/**
 * 图表头视图
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"
#import "ChartModel.h"
#import "ChartSubModel.h"
#import "BKModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ChartTableHeader : BaseView

@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, strong) ChartSubModel *subModel;
@property (nonatomic, strong) BKModel *model;

@end

NS_ASSUME_NONNULL_END
