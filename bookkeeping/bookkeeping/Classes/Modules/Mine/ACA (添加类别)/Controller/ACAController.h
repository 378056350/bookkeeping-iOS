/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 * @author 郑业强 2019-01-04 添加本地数据
 */

#import "BaseViewController.h"
#import "BKCIncomeModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - typedef
typedef void (^ACAControllerBlock)(BKCModel *model);

#pragma mark - 声明
@interface ACAController : BaseViewController

@property (nonatomic, assign) BOOL is_income;               // 是否是收入
@property (nonatomic, copy  ) ACAControllerBlock complete;  // 成功

@end

NS_ASSUME_NONNULL_END
