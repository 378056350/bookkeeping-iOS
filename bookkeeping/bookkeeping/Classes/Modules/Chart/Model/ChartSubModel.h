/**
 * 子时间范围
 * @author 郑业强 2018-12-29 创建文件
 */

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartSubModel : BaseModel

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger week_day;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) NSInteger selectIndex;

+ (instancetype)init;

@end

NS_ASSUME_NONNULL_END
