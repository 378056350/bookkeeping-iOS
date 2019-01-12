/**
 * 存储管理
 * @author 郑业强 2019-01-12 创建文件
 */

#import "NSUserDefaults+Extension.h"
#import "ACAListModel.h"


@implementation NSUserDefaults (Extension)


// 取值
+ (id)objectForKey:(NSString *)key {
    NSUserDefaults *sharedData = [[NSUserDefaults alloc] initWithSuiteName:@"group.book.widget"];
    id obj = [sharedData objectForKey:key];
    obj = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    return obj;
}

// 存值
+ (void)setObject:(id)obj forKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *sharedData = [[NSUserDefaults alloc] initWithSuiteName:@"group.book.widget"];
    [sharedData setObject:data forKey:key];
    [sharedData synchronize];
}


+ (void)load {
    BOOL isFirst = [NSUserDefaults objectForKey:PIN_FIRST_RUN];
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
        [NSUserDefaults setObject:pay forKey:PIN_CATE_SYS_HAS_PAY];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_PAY_SYNCED];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
        
        // 收入
        [NSUserDefaults setObject:income forKey:PIN_CATE_SYS_HAS_INCOME];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_INCOME];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_INCOME];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];
        
        // 添加类别
        NSString *acaPath = [[NSBundle mainBundle] pathForResource:@"ACA" ofType:@"plist"];
        NSMutableArray *acaArr = [NSMutableArray arrayWithContentsOfFile:acaPath];
        acaArr = [ACAListModel mj_objectArrayWithKeyValuesArray:acaArr];
        [NSUserDefaults setObject:acaArr forKey:PIN_ACA_CATE];
        
        // 记账
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_BOOK];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_BOOK_SYNCED];
        
        // 个人设置
        [NSUserDefaults setObject:@(0) forKey:PIN_SETTING_SOUND];
        [NSUserDefaults setObject:@(0) forKey:PIN_SETTING_DETAIL];
        [NSUserDefaults setObject:@(0) forKey:PIN_SETTING_SOUND_SYNCED];
        [NSUserDefaults setObject:@(0) forKey:PIN_SETTING_DETAIL_SYNCED];
        
        // 定时
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_TIMING];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_TIMING_HAS_SYNCED];
        [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_TIMING_REMOVE_SYNCED];
        
        
        [NSUserDefaults setObject:@(1) forKey:PIN_FIRST_RUN];
    }
}



@end
