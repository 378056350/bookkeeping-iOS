/**
 * 我的
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BaseView.h"
#import "MineTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineView : BaseView

@property (nonatomic, strong) MineTableView *table;
@property (nonatomic, strong) UserModel *model;

@end

NS_ASSUME_NONNULL_END
