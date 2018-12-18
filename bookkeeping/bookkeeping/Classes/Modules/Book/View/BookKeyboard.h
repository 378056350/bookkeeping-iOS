/**
 * 键盘
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookKeyboard : BaseView

@property (nonatomic, strong) NSMutableString *money;

+ (instancetype)init;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
