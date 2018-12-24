/**
 * 地址
 * @author 郑业强 2018-12-21 创建文件
 */

#import <Foundation/Foundation.h>


//#define KHost @"http://127.0.0.1:8080"
#define KHost @"http://192.168.1.7:8080"
//#define KStatic(str) [NSString stringWithFormat:@"http://127.0.0.1:8080/media/%@", str]
#define KStatic(str) [NSString stringWithFormat:@"http://192.168.1.7:8080/media/%@", str]
#define kUser  @"kUser"
#define Request(A) [NSString stringWithFormat:@"%@%@", KHost, A]



// 我的徽章列表
#define BadgeListRequest Request(@"/shayu/getBadgeRequest.action")
// 添加类别列表
#define InsertCategoryListRequest Request(@"/shayu/getInsertCategoryRequest.action")
// 添加自定义类别
#define AddInsertCategoryListRequest Request(@"/shayu/addInsertCategoryRequest.action")
// 删除自定义类别
#define RemoveInsertCategoryListRequest Request(@"/shayu/removeInsertCategoryRequest.action")
// 记账列表
#define CategoryListRequest Request(@"/shayu/getCategoryRequest.action")
// 类别设置列表
#define CategorySetListRequest Request(@"/shayu/getCategorySetRequest.action")

// 添加系统类别
#define AddSystemCategoryRequest Request(@"/shayu/addSystemCategoryRequest.action")
// 删除系统类别
#define RemoveSystemCategoryRequest Request(@"/shayu/removeSystemCategoryRequest.action")


// QQ第三方登录
#define QQLoginRequest Request(@"/shayu/getQQLoginRequest.action")
// 账号登录
#define PhoneLoginRequest Request(@"/shayu/getLoginRequest.action")
// 注册
#define RegisterRequest Request(@"/shayu/getRegisterRequest.action")
// 创建验证码
#define CreateCoderequest Request(@"/shayu/createCodeRequest.action")
