/**
 * 图表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"
#import "ChartModel.h"
#import "ChartSubModel.h"
#import "HomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 声明
@interface BookChart : BaseView

@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, strong) NSMutableArray<HomeListModel *> *listModels;
@property (nonatomic, strong) ChartSubModel *subModel;

@end

NS_ASSUME_NONNULL_END
