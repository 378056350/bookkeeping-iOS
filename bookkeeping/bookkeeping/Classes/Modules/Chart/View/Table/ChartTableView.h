/**
 * 列表
 * @author 郑业强 2018-12-18 创建文件
 */

#import <UIKit/UIKit.h>
#import "ChartModel.h"
#import "ChartSubModel.h"
#import "HomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartTableView : UITableView

@property (nonatomic, assign) NSInteger navigationIndex;
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, strong) NSMutableArray<ChartModel *> *groupModels;
@property (nonatomic, strong) NSMutableArray<HomeListModel *> *listModels;
@property (nonatomic, strong) ChartSubModel *subModel;

+ (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
