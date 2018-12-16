/**
 * 用户信息
 * @author 郑业强 2018-11-20
 */

#import <Foundation/Foundation.h>
//#import <PINCache/PINDiskCache.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject

// 是否登录
+ (BOOL)isLogin;

// 保存个人信息
+ (void)saveUserInfo:(NSDictionary *)param;
// 读取个人信息
+ (UserModel *)loadUserInfo;

@end

NS_ASSUME_NONNULL_END
