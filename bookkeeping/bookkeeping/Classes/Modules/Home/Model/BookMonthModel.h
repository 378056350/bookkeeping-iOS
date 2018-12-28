/**
 * 月份model
 * @author 郑业强 2018-12-28 创建文件
 */

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookMonthModel : BaseModel

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger customer_id;
@property (nonatomic, assign) NSInteger cate_or_insert_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon_n;
@property (nonatomic, strong) NSString *icon_l;
@property (nonatomic, strong) NSString *icon_s;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, assign) NSInteger is_income;
@property (nonatomic, assign) NSInteger is_system;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger week_day;



@end

NS_ASSUME_NONNULL_END
