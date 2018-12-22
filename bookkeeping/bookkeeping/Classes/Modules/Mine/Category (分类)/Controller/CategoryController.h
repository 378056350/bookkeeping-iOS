/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - typedef
typedef void (^CategoryControllerBlock)(void);

#pragma mark - 声明
@interface CategoryController : BaseViewController

@property (nonatomic, assign) BOOL is_income;                    // 是否是收入
@property (nonatomic, copy  ) CategoryControllerBlock complete;  // 成功

@end

NS_ASSUME_NONNULL_END
