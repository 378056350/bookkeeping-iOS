/**
 * 收入/支出切换
 * @author 郑业强 2018-12-28 创建文件
 */

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - typedef
typedef void (^ChartHudComplete)(NSInteger index);


#pragma mark - 声明
@interface ChartHud : BaseView

@property (nonatomic, copy  ) ChartHudComplete complete;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
