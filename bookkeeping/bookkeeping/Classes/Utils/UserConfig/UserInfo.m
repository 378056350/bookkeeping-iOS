/**
 * 用户信息
 * @author 郑业强 2018-11-20
 */

#import "UserInfo.h"

@implementation UserInfo

//// 是否登录
//+ (BOOL)isLogin {
//    // 有缓存
//    if ([[PINDiskCache sharedCache] containsObjectForKey:kUser]) {
//        return YES;
//    }
//    return NO;
//}
//
//
//// 保存个人信息
//+ (void)saveUserInfo:(NSDictionary *)param {
//    [[PINDiskCache sharedCache] setObject:param forKey:kUser];
//}
//// 读取个人信息
//+ (UserModel *)loadUserInfo {
//    NSDictionary *param = (NSDictionary *)[[PINDiskCache sharedCache] objectForKey:kUser];
//    UserModel *model = [UserModel mj_objectWithKeyValues:param];
//    return model;
//}


@end
