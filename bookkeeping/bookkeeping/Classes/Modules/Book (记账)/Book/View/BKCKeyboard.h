/**
 * 键盘
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BaseView.h"
#import "BKModel.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - typedef
typedef void (^BookComplete)(NSString *price, NSString *mark, NSDate *date);

#pragma mark - 声明
@interface BKCKeyboard : BaseView

@property (nonatomic, strong) NSMutableString *money;
@property (nonatomic, copy  ) BookComplete complete;
@property (nonatomic, strong) BKModel *model;

+ (instancetype)init;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
