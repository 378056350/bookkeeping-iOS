/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 * @author 郑业强 2019-01-04 添加本地数据
 */

#import "CAController.h"
#import "CAHeader.h"
#import "CategoryTable.h"
#import "BottomButton.h"
#import "ACAController.h"
#import "CategoryCell.h"
#import "CategoryListModel.h"
#import "CA_EVENT.h"


#pragma mark - 声明
@interface CAController()

@property (nonatomic, strong) CAHeader *header;
@property (nonatomic, strong) CategoryTable *table;
@property (nonatomic, strong) BottomButton *bootom;
@property (nonatomic, strong) NSMutableArray<CategoryListModel *> *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation CAController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"类别设置"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self header];
    [self table];
    [self bootom];
    [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [self.view bringSubviewToFront:self.bootom];
    if (_is_income == true) {
        [_header.seg setSelectedSegmentIndex:1];
    }
//    [self getCategoryListRequest];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        NSMutableArray<BKCModel *> *sysHasPayArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_HAS_PAY];
        NSMutableArray<BKCModel *> *cusHasPayArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_HAS_PAY];
        NSMutableArray<BKCModel *> *sysRemovePayArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_PAY];
        
        CategoryListModel *model1 = [[CategoryListModel alloc] init];
        model1.is_income = 0;
        model1.remove = sysRemovePayArr;
        model1.insert = ({
            NSMutableArray *arrm = [NSMutableArray arrayWithArray:sysHasPayArr];
            [arrm addObjectsFromArray:cusHasPayArr];
            arrm;
        });
        
        
        NSMutableArray<BKCModel *> *sysHasIncomeArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_HAS_INCOME];
        NSMutableArray<BKCModel *> *cusHasIcomeEArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_HAS_INCOME];
        NSMutableArray<BKCModel *> *sysRemoveIncomeArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_INCOME];
        
        CategoryListModel *model2 = [[CategoryListModel alloc] init];
        model2.is_income = 1;
        model2.remove = sysRemoveIncomeArr;
        model2.insert = ({
            NSMutableArray *arrm = [NSMutableArray arrayWithArray:sysHasIncomeArr];
            [arrm addObjectsFromArray:cusHasIcomeEArr];
            arrm;
        });
        
        
        [self setModels:[NSMutableArray arrayWithArray:@[model1, model2]]];
    });
}


#pragma mark - 请求
// 类别设置列表
- (void)getCategoryListRequest {
    @weakify(self)
    [self.table createRequest:CategorySetListRequest params:@{} complete:^(APPResult *result) {
        @strongify(self)
        [self setModels:[CategoryListModel mj_objectArrayWithKeyValuesArray:result.data]];
    }];
}
// 添加系统分类
- (void)addSysCateRequest:(CategoryCell *)cell {
    @weakify(self)
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @(cell.model.Id), @"category_id", nil];
    [self showProgressHUD];
    [AFNManager POST:AddSystemCategoryRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            NSInteger index = self.header.seg.selectedSegmentIndex;
            BKCModel *model = cell.model;
            [self.models[index].remove removeObject:model];
            [self.models[index].insert addObject:model];
            [self setModels:self.models];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}
// 删除系统分类
- (void)removeSysCateRequest:(CategoryCell *)cell {
    @weakify(self)
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @(cell.model.Id), @"category_id",
                           @(1), @"customer_id", nil];
    [self showProgressHUD];
    [AFNManager POST:RemoveSystemCategoryRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            [self showTextHUD:result.message delay:1.f];
            
            NSInteger index = self.header.seg.selectedSegmentIndex;
            BKCModel *model = cell.model;
            [self.models[index].insert removeObject:model];
            [self.models[index].remove addObject:model];
            [self setModels:self.models];
        } else {
            [self showTextHUD:result.message delay:1.f];
        }
    }];
}
// 删除自定义分类
- (void)removeCustrCateRequest:(CategoryCell *)cell {
    @weakify(self)
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @(1), @"customer_id", nil];
    [self showProgressHUD];
    [AFNManager POST:RemoveInsertCategoryListRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            [self showTextHUD:result.message delay:1.5f];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.models[self.header.seg.selectedSegmentIndex].insert removeObject:cell.model];
                [self setModels:self.models];
            });
        } else {
            [self showTextHUD:result.message delay:1.5f];
        }
    }];
}


#pragma mark - set
- (void)setModels:(NSMutableArray<CategoryListModel *> *)models {
    _models = models;
    _table.model = _models[_header.seg.selectedSegmentIndex];
}


#pragma mark - 事件
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    [self handleEventWithName:eventName data:data];
}
- (void)handleEventWithName:(NSString *)eventName data:(id)data {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    [super routerEventWithName:eventName data:data];
}
// 添加类别
- (void)categoryBtnClick:(id)data {
    ACAController *vc = [[ACAController alloc] init];
    [vc setIs_income:_header.seg.selectedSegmentIndex == 0 ? false : true];
    [vc setComplete:^(BKCModel *submodel) {
        NSInteger index = self.header.seg.selectedSegmentIndex;
        CategoryListModel *model = self.models[self.header.seg.selectedSegmentIndex];
        [model.insert addObject:submodel];
        [self.models replaceObjectAtIndex:index withObject:model];
        [self.table reloadData];
        
        
        if (self.complete) {
            self.complete();
        }
    }];
//    [vc setComplete:^{
//        [self.table.mj_header beginRefreshing];
//        if (self.complete) {
//            self.complete();
//        }
//    }];
    [self.navigationController pushViewController:vc animated:YES];
}
// 值改变
- (void)segValueChange:(NSNumber *)number {
    _table.model = _models[[number integerValue]];
}
// 删除cell
- (void)deleteCellClick:(CategoryCell *)cell {
    // 系统原有
    if (cell.model.is_system == true) {
//        [self removeSysCateRequest:cell];
        
        NSInteger index = self.header.seg.selectedSegmentIndex;
        BKCModel *model = cell.model;
        [self.models[index].insert removeObject:model];
        [self.models[index].remove addObject:model];
        [self setModels:self.models];
        
        if (index == 0) {
            NSIndexPath *indexPath = cell.indexPath;
            NSMutableArray<BKCModel *> *sysHasArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_HAS_PAY];
            NSMutableArray<BKCModel *> *sysRemoveArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_PAY];
            NSMutableArray<BKCModel *> *sysHasSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_Has_PAY_SYNCED];
            NSMutableArray<BKCModel *> *sysRemoveSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
            [sysRemoveArr addObject:sysHasArr[indexPath.row]];
            if ([sysHasSyncedArr containsObject:sysHasArr[indexPath.row]]) {
                [sysHasSyncedArr removeObject:sysHasArr[indexPath.row]];
            } else {
                [sysRemoveSyncedArr addObject:sysHasArr[indexPath.row]];
            }
            [sysHasArr removeObjectAtIndex:indexPath.row];
            
            [[PINDiskCache sharedCache] setObject:sysHasArr forKey:PIN_CATE_SYS_HAS_PAY];
            [[PINDiskCache sharedCache] setObject:sysRemoveArr forKey:PIN_CATE_SYS_REMOVE_PAY];
            [[PINDiskCache sharedCache] setObject:sysHasSyncedArr forKey:PIN_CATE_SYS_Has_PAY_SYNCED];
            [[PINDiskCache sharedCache] setObject:sysRemoveSyncedArr forKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
        }
        else if (index == 1) {
            NSIndexPath *indexPath = cell.indexPath;
            NSMutableArray<BKCModel *> *sysHasArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_HAS_INCOME];
            NSMutableArray<BKCModel *> *sysRemoveArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_INCOME];
            NSMutableArray<BKCModel *> *sysHasSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
            NSMutableArray<BKCModel *> *sysRemoveSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
            [sysRemoveArr addObject:sysHasArr[indexPath.row]];
            if ([sysHasSyncedArr containsObject:sysHasArr[indexPath.row]]) {
                [sysHasSyncedArr removeObject:sysHasArr[indexPath.row]];
            } else {
                [sysRemoveSyncedArr addObject:sysHasArr[indexPath.row]];
            }
            [sysHasArr removeObjectAtIndex:indexPath.row];
            
            [[PINDiskCache sharedCache] setObject:sysHasArr forKey:PIN_CATE_SYS_HAS_INCOME];
            [[PINDiskCache sharedCache] setObject:sysRemoveArr forKey:PIN_CATE_SYS_REMOVE_INCOME];
            [[PINDiskCache sharedCache] setObject:sysHasSyncedArr forKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
            [[PINDiskCache sharedCache] setObject:sysRemoveSyncedArr forKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
        }
    }
    // 自定义
    else {
//        [self removeCustrCateRequest:cell];
        
        NSInteger index = self.header.seg.selectedSegmentIndex;
        BKCModel *model = cell.model;
        [self.models[index].insert removeObject:model];
        [self setModels:self.models];
        
        
        if (index == 0) {
            NSMutableArray *cusHasPayArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_HAS_PAY];
            NSMutableArray *cusHasPaySyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
            NSMutableArray *cusRemovePaySyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
            [cusHasPayArr removeObject:model];
            if ([cusHasPaySyncedArr containsObject:model]) {
                [cusHasPaySyncedArr removeObject:model];
            } else {
                [cusRemovePaySyncedArr addObject:model];
            }
            [[PINDiskCache sharedCache] setObject:cusHasPayArr forKey:PIN_CATE_CUS_HAS_PAY];
            [[PINDiskCache sharedCache] setObject:cusHasPaySyncedArr forKey:PIN_CATE_CUS_HAS_PAY_SYNCED];
            [[PINDiskCache sharedCache] setObject:cusRemovePaySyncedArr forKey:PIN_CATE_CUS_REMOVE_PAY_SYNCED];
        } else if (index == 1) {
            NSMutableArray *cusHasIcomeEArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_HAS_INCOME];
            NSMutableArray *cusHasIncomeSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
            NSMutableArray *cusRemoveIncomeSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];
            [cusHasIcomeEArr removeObject:model];
            if ([cusHasIncomeSyncedArr containsObject:model]) {
                [cusHasIncomeSyncedArr removeObject:model];
            } else {
                [cusRemoveIncomeSyncedArr addObject:model];
            }
            [[PINDiskCache sharedCache] setObject:cusHasIcomeEArr forKey:PIN_CATE_CUS_HAS_INCOME];
            [[PINDiskCache sharedCache] setObject:cusHasIncomeSyncedArr forKey:PIN_CATE_CUS_HAS_INCOME_SYNCED];
            [[PINDiskCache sharedCache] setObject:cusRemoveIncomeSyncedArr forKey:PIN_CATE_CUS_REMOVE_INCOME_SYNCED];
        }
        
        
    }
    
    
    if (self.complete) {
        self.complete();
    }
    
}
// 添加系统分类
- (void)insertCellClick:(CategoryCell *)cell {
//    [self addSysCateRequest:cell];
    
    NSInteger index = self.header.seg.selectedSegmentIndex;
    BKCModel *model = cell.model;
    [self.models[index].remove removeObject:model];
    [self.models[index].insert addObject:model];
    [self setModels:self.models];
    
    
    if (index == 0) {
        NSIndexPath *indexPath = cell.indexPath;
        NSMutableArray *sysHasArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_HAS_PAY];
        NSMutableArray *sysRemoveArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_PAY];
        NSMutableArray *sysHasSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_Has_PAY_SYNCED];
        NSMutableArray *sysRemoveSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
        
        [sysHasArr addObject:sysRemoveArr[indexPath.row]];
        if ([sysRemoveSyncedArr containsObject:sysRemoveArr[indexPath.row]]) {
            [sysRemoveSyncedArr removeObject:sysRemoveArr[indexPath.row]];
        } else {
            [sysHasSyncedArr addObject:sysRemoveArr[indexPath.row]];
        }
        [sysRemoveArr removeObjectAtIndex:indexPath.row];
        
        
        [[PINDiskCache sharedCache] setObject:sysHasArr forKey:PIN_CATE_SYS_HAS_PAY];
        [[PINDiskCache sharedCache] setObject:sysRemoveArr forKey:PIN_CATE_SYS_REMOVE_PAY];
        [[PINDiskCache sharedCache] setObject:sysHasSyncedArr forKey:PIN_CATE_SYS_Has_PAY_SYNCED];
        [[PINDiskCache sharedCache] setObject:sysRemoveSyncedArr forKey:PIN_CATE_SYS_REMOVE_PAY_SYNCED];
    } else if (index == 1) {
        NSIndexPath *indexPath = cell.indexPath;
        NSMutableArray *sysHasArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_HAS_INCOME];
        NSMutableArray *sysRemoveArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_INCOME];
        NSMutableArray *sysHasSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
        NSMutableArray *sysRemoveSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
        
        [sysHasArr addObject:sysRemoveArr[indexPath.row]];
        if ([sysRemoveSyncedArr containsObject:sysRemoveArr[indexPath.row]]) {
            [sysRemoveSyncedArr removeObject:sysRemoveArr[indexPath.row]];
        } else {
            [sysHasSyncedArr addObject:sysRemoveArr[indexPath.row]];
        }
        [sysRemoveArr removeObjectAtIndex:indexPath.row];
        
        
        [[PINDiskCache sharedCache] setObject:sysHasArr forKey:PIN_CATE_SYS_HAS_INCOME];
        [[PINDiskCache sharedCache] setObject:sysRemoveArr forKey:PIN_CATE_SYS_REMOVE_INCOME];
        [[PINDiskCache sharedCache] setObject:sysHasSyncedArr forKey:PIN_CATE_SYS_Has_INCOME_SYNCED];
        [[PINDiskCache sharedCache] setObject:sysRemoveSyncedArr forKey:PIN_CATE_SYS_REMOVE_INCOME_SYNCED];
    }
    
    
}


#pragma mark - get
- (CAHeader *)header {
    if (!_header) {
        _header = [CAHeader loadFirstNib:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, countcoordinatesX(50))];
        [self.view addSubview:_header];
    }
    return _header;
}
- (CategoryTable *)table {
    if (!_table) {
        _table = [CategoryTable initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.header.bottom - self.bootom.height)];
        [self.view addSubview:_table];
    }
    return _table;
}
- (BottomButton *)bootom {
    if (!_bootom) {
        _bootom = [BottomButton initWithFrame:({
            CGFloat height = countcoordinatesX(50) + SafeAreaBottomHeight;
            CGFloat top = SCREEN_HEIGHT - height;
            CGRectMake(0, top, SCREEN_WIDTH, height);
        })];
        [_bootom setName:@"添加类别"];
        [self.view addSubview:_bootom];
    }
    return _bootom;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           CATEGORY_BTN_CLICK: [self createInvocationWithSelector:@selector(categoryBtnClick:)],
                           CATEGORY_SEG_CHANGE: [self createInvocationWithSelector:@selector(segValueChange:)],
                           CATEGORY_ACTION_DELETE_CLICK: [self createInvocationWithSelector:@selector(deleteCellClick:)],
                           CATEGORY_ACTION_INSERT_CLICK: [self createInvocationWithSelector:@selector(insertCellClick:)],
                           };
    }
    return _eventStrategy;
}


@end
