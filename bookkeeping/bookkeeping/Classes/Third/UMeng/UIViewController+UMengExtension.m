/**
 * 友盟扩展
 * @author 郑业强 2018-12-25 创建文件
 */

#import "UIViewController+UMengExtension.h"

@implementation UIViewController (UMengExtension)

// QQ授权
- (void)umQQUserInfo:(umComplete)complete {
    @weakify(self)
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        @strongify(self)
        // 失败
        if (error) {
            [self showTextHUD:@"登录失败" delay:1.5f];
        }
        // 成功
        else {
            // 下载图片
            [self showProgressHUD];
            KKSocialUserInfoResponse *resp = [KKSocialUserInfoResponse create:result];
            NSURL *url = [NSURL URLWithString:resp.iconurl];
            [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                // 成功
                if (!error) {
                    resp.icon = image;
                }
                // 回调
                if (complete) {
                    complete(resp);
                }
                else {
                    [self hideHUD];
                }
            }];
        }
    }];
}

@end
