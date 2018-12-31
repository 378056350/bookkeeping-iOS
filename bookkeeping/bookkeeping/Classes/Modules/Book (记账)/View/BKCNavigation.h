/**
 * 添加记账导航栏
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BKCNavigation : BaseView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat offsetX;

- (void)setIndex:(NSInteger)index;
- (void)setIndex:(NSInteger)index animation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
