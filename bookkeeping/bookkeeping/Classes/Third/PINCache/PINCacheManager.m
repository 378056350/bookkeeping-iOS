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
static PINDiskCache *_disk;


+ (PINDiskCache *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _disk = [[PINDiskCache sharedCache] initWithName:@"book" rootPath:@"Library/Caches/widget"];
    });
    return _disk;
}

// 初始化
+ (void)pinCacheManager {
    // Library/Caches/widget
    
    BOOL isFirst = [[PINCacheManager sharedManager] containsObjectForKey:PIN_FIRST_RUN];
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
        [[PINCacheManager sharedManager] setObject:pay forKey:PIN_CATE_SYS_HAS_PAY];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_PAY_SYNCED];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
        
        // 收入
        [[PINCacheManager sharedManager] setObject:income forKey:PIN_CATE_SYS_HAS_INCOME];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_INCOME];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_INCOME];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];
        
        // 添加类别
        NSString *acaPath = [[NSBundle mainBundle] pathForResource:@"ACA" ofType:@"plist"];
        NSMutableArray *acaArr = [NSMutableArray arrayWithContentsOfFile:acaPath];
        acaArr = [ACAListModel mj_objectArrayWithKeyValuesArray:acaArr];
        [[PINCacheManager sharedManager] setObject:acaArr forKey:PIN_ACA_CATE];
        
        
        // 记账
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_BOOK];
        [[PINCacheManager sharedManager] setObject:[NSMutableArray array] forKey:PIN_BOOK_SYNCED];
        
        
        // 个人设置
        [[PINCacheManager sharedManager] setObject:@(0) forKey:PIN_SETTING_SOUND];
        [[PINCacheManager sharedManager] setObject:@(0) forKey:PIN_SETTING_DETAIL];
        [[PINCacheManager sharedManager] setObject:@(0) forKey:PIN_SETTING_SOUND_SYNCED];
        [[PINCacheManager sharedManager] setObject:@(0) forKey:PIN_SETTING_DETAIL_SYNCED];
        
        
        
        [[PINCacheManager sharedManager] setObject:@(1) forKey:PIN_FIRST_RUN];
    }
}


@end
