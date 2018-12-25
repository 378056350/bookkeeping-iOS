/**
 * 友盟扩展
 * @author 郑业强 2018-12-25 创建文件
 */

#import <UIKit/UIKit.h>
#import "KKSocialUserInfoResponse.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - type
typedef void (^umComplete) (KKSocialUserInfoResponse *resp);


#pragma mark - 声明
@interface UIViewController (UMengExtension)

- (void)umQQUserInfo:(umComplete)complete;

@end


NS_ASSUME_NONNULL_END
