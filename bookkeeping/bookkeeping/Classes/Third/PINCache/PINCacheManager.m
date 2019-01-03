/**
 * 本地数据管理
 * @author 郑业强 2010-01-03 创建文件
 */

#import "PINCacheManager.h"


#pragma mark - 声明
@interface PINCacheManager()

@end


#pragma mark - 实现
@implementation PINCacheManager
SingleImplementation(PINCacheManager)


// 初始化
+ (void)pinCacheManager {
    BOOL isFirst = [[PINDiskCache sharedCache] containsObjectForKey:PIN_FIRST_RUN];
    // 第一次运行
    if (!isFirst) {
        // 系统类别
        NSString *systemCatePath = [[NSBundle mainBundle] pathForResource:@"SystemCategory" ofType:@"plist"];
        NSArray *systemCateArr = [NSArray arrayWithContentsOfFile:systemCatePath];
        [[PINDiskCache sharedCache] setObject:systemCateArr forKey:PIN_CATE_SYS_HAS];
        
        // PIN_CATE_SYS_HAS 用户 添加
        
        [[PINDiskCache sharedCache] setObject:@(1) forKey:PIN_FIRST_RUN];
    }
}


@end
