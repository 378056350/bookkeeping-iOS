/**
 * 系统配置
 * @author 郑业强 2018-12-16 创建文件
 */

#import "AppDelegate.h"
#import "AppDelegate+UMeng.h"

#pragma mark - 声明
@interface AppDelegate ()

@end


#pragma mark - 实现
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 本地数据配置
    [PINCacheManager pinCacheManager];
    // 根控制器
    [self makeRootController];
    // 系统配置
    [self systemConfig];
    // 友盟
    [self shareUMengConfig];
    
    
    ////    NSArray *arr = @[@"餐饮",@"零食",@"购物",@"交通",@"运动",@"汽车",@"医疗",@"宠物",@"书籍",@"学习",@"礼物",@"办公",@"维修",@"捐赠",@"彩票",@"快递",@"社交",@"美容",@"水果",@"旅行",@"娱乐",@"礼金",@"蔬菜",@"长辈",@"住房",@"孩子",@"通讯",@"服饰",@"日用",@"烟酒",@"亲友",@"数码",@"居家"];
    //    NSArray *arr = @[@"工资",@"兼职",@"理财",@"礼金",@"其它"];
    //    NSMutableString *strm = [[NSMutableString alloc] init];
    //    for (NSInteger i=34; i<arr.count + 34; i++) {
    //        [strm appendFormat:@"<dict>\n"];
    //        [strm appendFormat:@"<key>id</key>\n"];
    //        [strm appendFormat:@"<integer>%ld</integer>\n", i];
    //        [strm appendFormat:@"<key>icon_n</key>\n"];
    //        [strm appendFormat:@"<string>book/e_snack@3x.png</string>\n"];
    //        [strm appendFormat:@"<key>icon_l</key>\n"];
    //        [strm appendFormat:@"<string>book/e_snack_l@3x.png</string>\n"];
    //        [strm appendFormat:@"<key>icon_s</key>\n"];
    //        [strm appendFormat:@"<string>book/e_snack_s@3x.png</string>\n"];
    //        [strm appendFormat:@"<key>is_income</key>\n"];
    //        [strm appendFormat:@"<integer>1</integer>\n"];
    //        [strm appendFormat:@"<key>is_system</key>\n"];
    //        [strm appendFormat:@"<integer>1</integer>\n"];
    //        [strm appendFormat:@"<key>name</key>\n"];
    //        [strm appendFormat:@"<string>%@</string>\n", arr[i-34]];
    //        [strm appendFormat:@"</dict>\n"];
    //    }
    
    
//    NSArray *arr = @[@"娱乐",@"饮食",@"医疗",@"学习",@"交通",@"购物",@"生活",@"个人",@"家居",@"家庭",@"健身",@"办公",@"收入",@"其他"];
//    NSMutableString *strm = [[NSMutableString alloc] init];
//    for (NSInteger i=1; i<arr.count + 1; i++) {
//        [strm appendFormat:@"<dict>\n"];
//        [strm appendFormat:@"<key>id</key>\n"];
//        [strm appendFormat:@"<integer>%ld</integer>\n", i];
//        [strm appendFormat:@"<key>name</key>\n"];
//        [strm appendFormat:@"<string>%@</string>\n", arr[i - 1]];
//        [strm appendFormat:@"<key>list</key>\n"];
//        [strm appendFormat:@"<array>\n"];
//        for (NSInteger y=1; y<8; y++) {
//            [strm appendFormat:@"<dict>\n"];
//            [strm appendFormat:@"<key>id</key>\n"];
//            [strm appendFormat:@"<integer>%ld</integer>\n", y + (i - 1) * 7];
//            [strm appendFormat:@"<key>section_id</key>\n"];
//            [strm appendFormat:@"<integer>%ld</integer>\n", i];
//            [strm appendFormat:@"<key>icon_n</key>\n"];
//            [strm appendFormat:@"<string>book/e_digital@3x.png</string>\n"];
//            [strm appendFormat:@"<key>icon_l</key>\n"];
//            [strm appendFormat:@"<string>book/e_digital_l@3x.png</string>\n"];
//            [strm appendFormat:@"<key>icon_s</key>\n"];
//            [strm appendFormat:@"<string>book/e_digital_s@3x.png</string>\n"];
//            [strm appendFormat:@"</dict>\n"];
//        }
//        [strm appendFormat:@"</array>\n"];
//        [strm appendFormat:@"</dict>\n"];
//    }
    
    
    
    return YES;
}
// 根控制器
- (void)makeRootController {
    [self setWindow:[[UIWindow alloc] initWithFrame:SCREEN_BOUNDS]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:({BaseTabBarController *tab = [[BaseTabBarController alloc] init];tab;
    })];
    [self.window makeKeyAndVisible];
}
// 配置
- (void)systemConfig {
    [[UITextField appearance] setTintColor:kColor_Main_Color];
}



// 支持所有iOS系统
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
    }
    return result;
}


@end
