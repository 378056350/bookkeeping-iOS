/**
 * 网页
 * @author 郑业强 2018-11-15
 */

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebVC : BaseViewController

@property (nonatomic, strong) NSString *url;        // 链接
@property (nonatomic, assign) BOOL showProgress;    // 是否显示进度条(默认显示)

@end

NS_ASSUME_NONNULL_END
