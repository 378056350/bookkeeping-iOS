/**
 * 类别设置
 * @author 郑业强 2018-12-21 创建文件
 */

#import "BaseModel.h"
#import "BKCIncomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryListModel : BaseModel<NSCoding>

@property (nonatomic, assign) BOOL is_income;
@property (nonatomic, strong) NSMutableArray<BKCModel *> *insert;
@property (nonatomic, strong) NSMutableArray<BKCModel *> *remove;

@end

NS_ASSUME_NONNULL_END
