/**
 * 记账列表
 * @author 郑业强 2018-12-21 创建文件
 */

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

// 记账model
@interface BKCModel : BaseModel<NSCoding, NSCopying>

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon_n;
@property (nonatomic, strong) NSString *icon_l;
@property (nonatomic, strong) NSString *icon_s;
@property (nonatomic, assign) BOOL is_income;
@property (nonatomic, assign) BOOL is_system;

+ (BKCModel *)createSetModel;

@end


// 记账收入/支出
@interface BKCIncomeModel : BaseModel<NSCoding>

@property (nonatomic, assign) BOOL is_income;
@property (nonatomic, strong) NSMutableArray<BKCModel *> *list;

@end


NS_ASSUME_NONNULL_END
