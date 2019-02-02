/**
 * 请求分类
 * @author 郑业强 2019-01-15 创建文件
 */

#import "UIView+SyncedData.h"

@implementation UIView (SyncedData)

/// 同步数据
- (void)syncedDataRequest {
    // 类别
    // 系统 - 添加的 - 支出
    NSMutableArray<BKCModel *> *cateSysHasPayArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_Has_PAY_SYNCED];
    // 系统 - 删除的 - 支出
    NSMutableArray<BKCModel *> *cateSysRemovePayArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
    // 用户 - 添加的 - 支出
    NSMutableArray<BKCModel *> *cateCusHasPayArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
    // 用户 - 删除的 - 支出
    NSMutableArray<BKCModel *> *cateCusRemovePayArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
    
    
    // 系统 - 添加的 - 收入
    NSMutableArray<BKCModel *> *cateSysHasIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
    // 系统 - 删除的 - 收入
    NSMutableArray<BKCModel *> *cateSysRemoveIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
    // 用户 - 添加的 - 收入
    NSMutableArray<BKCModel *> *cateCusHasIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
    // 用户 - 删除的 - 收入
    NSMutableArray<BKCModel *> *cateCusRemoveIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];
    
    
    // 记账信息
    NSMutableArray<BKModel *> *bookArr = [NSUserDefaults objectForKey:PIN_BOOK_SYNCED];
    
    
    // 声音开关
    NSNumber *sound = [NSUserDefaults objectForKey:PIN_SETTING_SOUND_SYNCED];
    // 明细详情
    NSNumber *detail = [NSUserDefaults objectForKey:PIN_SETTING_DETAIL_SYNCED];
    
    
    // 定时
    NSMutableArray *timing_has = [NSUserDefaults objectForKey:PIN_TIMING_HAS_SYNCED];
    NSMutableArray *timing_remove = [NSUserDefaults objectForKey:PIN_TIMING_REMOVE_SYNCED];
    
    
    // 参数
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateSysRemovePayArr] mj_JSONString], @"cateSysRemovePayArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateSysHasPayArr] mj_JSONString], @"cateSysHasPayArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateCusRemovePayArr] mj_JSONString], @"cateCusRemovePayArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateCusHasPayArr] mj_JSONString], @"cateCusHasPayArr",
                                  
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateSysRemoveIncomeArr] mj_JSONString], @"cateSysRemoveIncomeArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateSysHasIncomeArr] mj_JSONString], @"cateSysHasIncomeArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateCusRemoveIncomeArr] mj_JSONString], @"cateCusRemoveIncomeArr",
                                  [[BKCModel mj_keyValuesArrayWithObjectArray:cateCusHasIncomeArr] mj_JSONString], @"cateCusHasIncomeArr",
                                  
                                  [[BKModel mj_keyValuesArrayWithObjectArray:bookArr] mj_JSONString], @"book",
                                  sound, @"sound",
                                  detail, @"detail",
                                  [timing_has mj_JSONString], @"timing_has",
                                  [timing_remove mj_JSONString], @"timing_remove",
                                  nil];
    
    @weakify(self)
    [self showWindowTextHUD:@"同步中..."];
    [AFNManager POST:SyncedDataRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideWindowHUD];
        // 成功
        if (result.status == ServiceCodeSuccess) {
            
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_PAY_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
            
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];
            
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_BOOK_SYNCED];
            
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_TIMING_HAS_SYNCED];
            [NSUserDefaults setObject:[NSMutableArray array] forKey:PIN_TIMING_REMOVE_SYNCED];
            
            
            NSString *systemCatePath = [[NSBundle mainBundle] pathForResource:@"SC" ofType:@"plist"];
            NSDictionary *systemCateDic = [NSDictionary dictionaryWithContentsOfFile:systemCatePath];
            NSMutableArray<BKCModel *> *pay = [NSMutableArray arrayWithArray:systemCateDic[@"pay"]];
            NSMutableArray<BKCModel *> *income = [NSMutableArray arrayWithArray:systemCateDic[@"income"]];
            pay = [BKCModel mj_objectArrayWithKeyValuesArray:pay];
            income = [BKCModel mj_objectArrayWithKeyValuesArray:income];
            
            NSMutableArray<BKCModel *> *payRemove = [NSMutableArray array];
            NSMutableArray<BKCModel *> *incomeRemove = [NSMutableArray array];
            
            NSArray<NSArray *> *arr = result.data[@"delete_cate"];
            for (NSArray *subarr in arr) {
                NSInteger category_id = [subarr[0] integerValue];
                NSString *preStr = [NSString stringWithFormat:@"Id == %ld", category_id];
                NSPredicate *pre = [NSPredicate predicateWithFormat:preStr];
                if (category_id <= [pay lastObject].Id) {
                    NSMutableArray<BKModel *> *models = [NSMutableArray kk_filteredArrayUsingPredicate:preStr array:pay];
                    BKModel *model = [models firstObject];
                    [pay removeObject:model];
                    [payRemove addObject:model];
                } else {
                    NSMutableArray<BKModel *> *models = [NSMutableArray kk_filteredArrayUsingPredicate:preStr array:income];
                    BKModel *model = [models firstObject];
                    [income removeObject:model];
                    [incomeRemove addObject:model];
                }
            }
            
            [NSUserDefaults setObject:pay forKey:PIN_CATE_SYS_HAS_PAY];
            [NSUserDefaults setObject:payRemove forKey:PIN_CATE_SYS_REMOVE_PAY];
            
            [NSUserDefaults setObject:income forKey:PIN_CATE_SYS_HAS_INCOME];
            [NSUserDefaults setObject:incomeRemove forKey:PIN_CATE_SYS_REMOVE_INCOME];
            
            
            
            NSMutableArray *insertArr = result.data[@"insert_cate"];
            NSMutableArray<BKCModel *> *insertPayModel = [NSMutableArray array];
            NSMutableArray<BKCModel *> *insertIncomeModel = [NSMutableArray array];
            for (NSArray *arr in insertArr) {
                BKCModel *model = [[BKCModel alloc] init];
                model.Id = [arr[0] integerValue];
                model.name = arr[1];
                model.icon_n = arr[2];
                model.icon_l = arr[3];
                model.icon_s = arr[4];
                model.is_income = [arr[5] boolValue];
                model.is_system = [arr[6] boolValue];
                if ([param[@"is_income"] boolValue] == true) {
                    [insertIncomeModel addObject:model];
                } else {
                    [insertPayModel addObject:model];
                }
            }
            [NSUserDefaults setObject:insertPayModel forKey:PIN_CATE_CUS_HAS_PAY];
            [NSUserDefaults setObject:insertIncomeModel forKey:PIN_CATE_CUS_HAS_INCOME];
            
            
            
            NSArray *setting = result.data[@"setting"][0];
            NSNumber *sound = setting[0];
            NSNumber *detail = setting[1];
            [NSUserDefaults setObject:sound forKey:PIN_SETTING_SOUND];
            [NSUserDefaults setObject:detail forKey:PIN_SETTING_DETAIL];
            
            
            
            NSArray<NSArray *> *bookarr = result.data[@"book"];
            NSMutableArray<BKModel *> *bookModels = [NSMutableArray array];
            for (NSArray *subarr in bookarr) {
                BKModel *model = [[BKModel alloc] init];
                model.Id = [[BKModel getId] integerValue];
                model.price = [subarr[0] floatValue];
                model.category_id = [subarr[1] integerValue];
                model.year = [subarr[2] integerValue];
                model.month = [subarr[3] integerValue];
                model.day = [subarr[4] integerValue];
                model.mark = subarr[5];
                model.cmodel = ({
                    BKCModel *submodel = [[BKCModel alloc] init];
                    submodel.Id = [subarr[1] integerValue];
                    submodel.name = subarr[8];
                    submodel.icon_n = subarr[9];
                    submodel.icon_l = subarr[10];
                    submodel.icon_s = subarr[11];
                    submodel.is_income = [subarr[6] boolValue];
                    submodel.is_system = [subarr[7] boolValue];
                    submodel;
                });
                [bookModels addObject:model];
            }
            [NSUserDefaults setObject:bookModels forKey:PIN_BOOK];
            
            
            
            UserModel *model = [UserInfo loadUserInfo];
            model.sound = [sound integerValue];
            model.detail = [detail integerValue];
            [UserInfo saveUserModel:model];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SYNCED_DATA_COMPLETE object:nil];
        }
        // 失败
        else {
            [self showWindowTextHUD:result.message delay:1.5f];
        }
    }];
}

@end
