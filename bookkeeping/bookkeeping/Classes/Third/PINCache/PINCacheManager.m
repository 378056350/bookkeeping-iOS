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
        //========================================== 分类 ==========================================//
        // 系统添加
        NSString *systemCatePath = [[NSBundle mainBundle] pathForResource:@"SystemCategory" ofType:@"plist"];
        NSDictionary *systemCateDic = [NSDictionary dictionaryWithContentsOfFile:systemCatePath];
        
        [[PINDiskCache sharedCache] setObject:[NSMutableArray arrayWithArray:systemCateDic[@"pay"]] forKey:PIN_CATE_SYS_HAS_PAY];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_PAY_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
    }
}


@end
