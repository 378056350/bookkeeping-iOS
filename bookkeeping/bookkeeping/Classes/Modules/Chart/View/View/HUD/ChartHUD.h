/**
 * 收入/支出切换
 * @author 郑业强 2018-12-28 创建文件
 */

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - typedef
typedef void (^ChartHUDComplete)(NSInteger index);


#pragma mark - 声明
@interface ChartHUD : BaseView

@property (nonatomic, copy  ) ChartHUDComplete complete;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
