/**
 * 记账model
 * @author 郑业强 2018-12-31 创建文件
 */

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

// 记账列表model
@interface BookListModel : BaseModel

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger customer_id;
@property (nonatomic, assign) NSInteger cate_or_insert_id;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger week_day;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger is_income;
@property (nonatomic, assign) NSInteger is_system;
@property (nonatomic, strong) NSString *icon_l;
@property (nonatomic, strong) NSString *icon_n;
@property (nonatomic, strong) NSString *icon_s;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mark;

@end


// 记账组model
@interface BookGroupModel : BaseModel

@property (nonatomic, assign) NSInteger customer_id;
@property (nonatomic, assign) NSInteger cate_or_insert_id;
@property (nonatomic, assign) NSInteger is_income;
@property (nonatomic, assign) NSInteger is_system;
@property (nonatomic, strong) NSString *icon_l;
@property (nonatomic, strong) NSString *icon_n;
@property (nonatomic, strong) NSString *icon_s;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString *name;

@end


// 记账组model
@interface BKModel : BaseModel

// 列表数据
@property (nonatomic, strong) NSMutableArray<BookListModel *> *list;
// 列表数据整理组合[按天数划分]
@property (nonatomic, strong) NSMutableArray<NSMutableArray<BookListModel *> *> *listSorts;
// 组数据
@property (nonatomic, strong) NSMutableArray<BookGroupModel *> *group;
// 收入
@property (nonatomic, assign) CGFloat income;
// 支出
@property (nonatomic, assign) CGFloat pay;

@end

NS_ASSUME_NONNULL_END
