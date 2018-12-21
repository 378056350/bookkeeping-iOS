/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseView.h"
#import "BadgeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BadgeCollection : BaseView

@property (nonatomic, strong) NSArray<BadgeListModel *> *models;

@end

NS_ASSUME_NONNULL_END
