/**
 * 头视图
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"
#import "BookMonthModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeListHeader : BaseView

@property (nonatomic, strong) NSMutableArray<BookMonthModel *> *models;

@end

NS_ASSUME_NONNULL_END
