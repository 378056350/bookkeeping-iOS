/**
 * 徽章
 * @author 郑业强 2018-12-21 创建文件
 */

#import "BaseView.h"
#import "BaseView+Popup.h"
#import "BadgeListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface KKBadge : BaseView<KKPopupDelegate>

@property (nonatomic, strong) BadgeModel *model;

@end

NS_ASSUME_NONNULL_END
