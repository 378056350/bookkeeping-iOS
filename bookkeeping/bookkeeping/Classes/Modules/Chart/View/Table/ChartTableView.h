/**
 * 列表
 * @author 郑业强 2018-12-18 创建文件
 */

#import <UIKit/UIKit.h>
#import "ChartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartTableView : UITableView

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSMutableArray<ChartModel *> *models;

+ (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
