/**
 * 本地数据管理
 * @author 郑业强 2010-01-03 创建文件
 */

#import "PINCacheManager.h"
#import "CategoryListModel.h"
#import "ACAListModel.h"


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
        // 分类
        NSString *systemCatePath = [[NSBundle mainBundle] pathForResource:@"SC" ofType:@"plist"];
        NSDictionary *systemCateDic = [NSDictionary dictionaryWithContentsOfFile:systemCatePath];
        NSMutableArray *pay = [NSMutableArray arrayWithArray:systemCateDic[@"pay"]];
        NSMutableArray *income = [NSMutableArray arrayWithArray:systemCateDic[@"income"]];
        pay = [BKCModel mj_objectArrayWithKeyValuesArray:pay];
        income = [BKCModel mj_objectArrayWithKeyValuesArray:income];

        // 支出
        [[PINDiskCache sharedCache] setObject:pay forKey:PIN_CATE_SYS_HAS_PAY];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_PAY_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
        
        // 收入
        [[PINDiskCache sharedCache] setObject:income forKey:PIN_CATE_SYS_HAS_INCOME];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_INCOME];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_INCOME];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
        [[PINDiskCache sharedCache] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];
        
        // 添加类别
        NSString *acaPath = [[NSBundle mainBundle] pathForResource:@"ACA" ofType:@"plist"];
        NSMutableArray *acaArr = [NSMutableArray arrayWithContentsOfFile:acaPath];
        acaArr = [ACAListModel mj_objectArrayWithKeyValuesArray:acaArr];
        [[PINDiskCache sharedCache] setObject:acaArr forKey:PIN_ACA_CATE];
        
        
        
        [[PINDiskCache sharedCache] setObject:@(1) forKey:PIN_FIRST_RUN];
    }
}


@end
