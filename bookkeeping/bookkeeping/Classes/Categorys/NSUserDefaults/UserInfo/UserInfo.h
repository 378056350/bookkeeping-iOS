/**
 * 用户信息
 * @author 郑业强 2018-11-20
 */

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject

// 是否登录
+ (BOOL)isLogin;

// 保存个人信息
+ (void)saveUserInfo:(NSDictionary *)param;
// 保存个人信息
+ (void)saveUserModel:(UserModel *)model;
// 读取个人信息
+ (UserModel *)loadUserInfo;

// 清除登录信息
+ (void)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
