/**
 * 图表
 * @author 郑业强 2018-12-29 创建文件
 */

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartModel : BaseModel

@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger customer_id;
@property (nonatomic, assign) NSInteger cate_or_insert_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon_n;
@property (nonatomic, strong) NSString *icon_l;
@property (nonatomic, strong) NSString *icon_s;
@property (nonatomic, assign) NSInteger is_income;
@property (nonatomic, assign) NSInteger is_system;

@end

NS_ASSUME_NONNULL_END
