/**
 * 用户信息
 * @author 郑业强 2018-11-20
 */

#import "UserInfo.h"

@implementation UserInfo


// 是否登录
+ (BOOL)isLogin {
    // 有缓存
    if ([[PINCacheManager sharedManager] containsObjectForKey:kUser]) {
        return YES;
    }
    return NO;
}


// 保存个人信息
+ (void)saveUserInfo:(NSDictionary *)param {
    [[PINCacheManager sharedManager] setObject:param forKey:kUser];
}
// 保存个人信息
+ (void)saveUserModel:(UserModel *)model {
    NSDictionary *param = [model mj_keyValues];
    [[PINCacheManager sharedManager] setObject:param forKey:kUser];
}
// 读取个人信息
+ (UserModel *)loadUserInfo {
    NSDictionary *param = (NSDictionary *)[[PINCacheManager sharedManager] objectForKey:kUser];
    UserModel *model = [UserModel mj_objectWithKeyValues:param];
    return model;
}


// 清除登录信息
+ (void)clearUserInfo {
    [[PINCacheManager sharedManager] removeObjectForKey:kUser];
}



@end
