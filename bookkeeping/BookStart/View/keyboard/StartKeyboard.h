/**
 * 键盘
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"
#import "BKModel.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - typedef
typedef void (^StartComplete)(NSString *price, NSString *mark, NSDate *date);


#pragma mark - 声明
@interface StartKeyboard : BaseView

@property (nonatomic, strong) NSMutableString *money;
@property (nonatomic, copy  ) StartComplete complete;

@end

NS_ASSUME_NONNULL_END
