/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 * @author 郑业强 2019-01-04 添加本地数据
 */

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - typedef
typedef void (^CAControllerBlock)(void);

#pragma mark - 声明
@interface CAController : BaseViewController

@property (nonatomic, assign) BOOL is_income;                 // 是否是收入
@property (nonatomic, copy  ) CAControllerBlock complete;     // 成功

@end

NS_ASSUME_NONNULL_END
