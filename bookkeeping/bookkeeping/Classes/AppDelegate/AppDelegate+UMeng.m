/**
 * 友盟m配置
 * @author 郑业强 2018-12-22 创建文件
 */

#import "AppDelegate+UMeng.h"

@implementation AppDelegate (UMeng)


// 友盟分享
- (void)shareUMengConfig {
    [UMConfigure initWithAppkey:kUMengAppKey channel:@"App Store"];
    
    // 微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx1372f021928ffa3d" appSecret:@"3b8cc89e1937c6ad0a463e65df58cfb7" redirectURL:@"http://mobile.umeng.com/social"];
    // 移除微信收藏
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    // QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106669216" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    // 新浪
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}


@end
