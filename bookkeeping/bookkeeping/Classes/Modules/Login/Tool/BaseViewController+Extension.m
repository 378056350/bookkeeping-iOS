/**
 * 工具类
 * @author 郑业强 2018-12-24 创建文件
 */

#import "BaseViewController+Extension.h"

@implementation BaseViewController (Extension)


- (void)startQQLogin:(LoginComplete)complete {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [self showTextHUD:@"登录失败" delay:1.5f];
        } else {
            UMSocialUserInfoResponse *resp = result;
            [self getQQLoginRequest:resp complete:complete];
        }
    }];
}

#pragma mark - 请求
// QQ登录
- (void)getQQLoginRequest:(UMSocialUserInfoResponse *)resp complete:(LoginComplete)complete {
    @weakify(self)
    // 下载图片
    NSURL *url = [NSURL URLWithString:resp.iconurl];
    [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        @strongify(self)
        // 失败
        if (error) {
            [self showTextHUD:@"图片获取失败" delay:1.5f];
            return;
        }
        // 成功
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               resp.openid, @"openid",
                               resp.name, @"nickname",
                               [resp.gender isEqualToString:@"男"] ? @(1) : @(0), @"sex", nil];
        NSArray *images = @[image];
        [self showProgressHUD];
        @weakify(self)
        [AFNManager POST:QQLoginRequest params:param andImages:images progress:nil complete:^(APPResult *result) {
            @strongify(self)
            [self hideHUD];
            if (result.status == ServiceCodeSuccess) {
                [UserInfo saveUserInfo:result.data];
                // 回调
                if (complete) {
                    complete();
                }
            } else {
                [self showTextHUD:result.message delay:1.5f];
            }
        }];
    }];
}



@end
