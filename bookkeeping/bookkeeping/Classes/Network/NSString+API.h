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



// 同步数据
#define SyncedDataRequest Request(@"/shayu/syncedDataRequest.action")

// 我的徽章列表
#define BadgeListRequest Request(@"/shayu/getBadgeListRequest.action")
// 类别设置列表
#define CategorySetListRequest Request(@"/shayu/getCategorySetRequest.action")
// 全部类别
#define CategoryListRequest Request(@"/shayu/getCategoryRequest.action")
// 用户类别列表
#define CustomerCategoryListRequest Request(@"/shayu/getCustomerCategoryListRequest.action")
// 添加系统类别
#define AddSystemCategoryRequest Request(@"/shayu/addSystemCategoryRequest.action")
// 删除系统类别
#define RemoveSystemCategoryRequest Request(@"/shayu/removeSystemCategoryRequest.action")
// 添加用户类别
#define AddInsertCategoryListRequest Request(@"/shayu/addInsertCategoryRequest.action")
// 删除用户类别
#define RemoveInsertCategoryListRequest Request(@"/shayu/removeInsertCategoryRequest.action")


// QQ第三方登录
#define QQLoginRequest Request(@"/shayu/getQQLoginRequest.action")
// 账号登录
#define PhoneLoginRequest Request(@"/shayu/getLoginRequest.action")
// 注册
#define RegisterRequest Request(@"/shayu/getRegisterRequest.action")
// 创建验证码
#define CreateCoderequest Request(@"/shayu/createCodeRequest.action")
// 验证验证码
#define ValidateCoderequest Request(@"/shayu/validateCodeRequest.action")
// 个人信息
#define InfoRequest Request(@"/shayu/getInfoRequest.action")
// 修改密码
#define ChangePassRequest Request(@"/shayu/changePassRequest.action")
// 忘记密码
#define ForgetPassRequest Request(@"/shayu/forgetPassRequest.action")
// 绑定第三方账号
#define BindThirdRequest Request(@"/shayu/bindThirdRequest.action")
// 绑定手机号
#define BindPhoneRequest Request(@"/shayu/bindPhoneRequest.action")
// 修改性别
#define ChangeSexRequest Request(@"/shayu/changeSexRequest.action")
// 修改昵称
#define NicknameRequest Request(@"/shayu/changeNameRequest.action")
// 修改头像
#define ChangeIconRequest Request(@"/shayu/changeIconRequest.action")

// 打卡
#define CreatePunchRequest Request(@"/shayu/createPunchRequest.action")
// 声音
#define SoundRequest Request(@"/shayu/soundRequest.action")
// 详情
#define DetailRequest Request(@"/shayu/detailRequest.action")
// 定时列表
#define TimeListRequest Request(@"/shayu/timeListRequest.action")
// 添加定时
#define AddTimeRequest Request(@"/shayu/addTimeRequest.action")
// 删除定时
#define RemoveTimeRequest Request(@"/shayu/removeTimeRequest.action")

// 记账
#define CreateBookRequest Request(@"/shayu/createBookRequest.action")
// 查账(条)
#define GetBookListRequest Request(@"/shayu/getBookListRequest.action")
// 查账(组)
#define getBookGroupRequest Request(@"/shayu/getBookGroupRequest.action")

