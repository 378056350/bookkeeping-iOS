/**
 * 记账分类
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BKCController.h"
#import "BKCCollection.h"
#import "BKCNavigation.h"
#import "BKCKeyboard.h"
#import "BKCIncomeModel.h"
#import "CAController.h"
#import "KKRefreshGifHeader.h"
#import "BOOK_EVENT.h"
#import "BKModel.h"


#pragma mark - 声明
@interface BKCController()<UIScrollViewDelegate>

@property (nonatomic, strong) BKCNavigation *navigation;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) NSMutableArray<BKCCollection *> *collections;
@property (nonatomic, strong) BKCKeyboard *keyboard;
@property (nonatomic, strong) NSArray<BKCIncomeModel *> *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation BKCController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:YES];
    [self setTitle:@"记账"];
    [self navigation];
    [self scroll];
    [self collections];
    [self keyboard];
//    [self getCategoryListRequest];
    
    
    /**
     
     // 支出
     #define PIN_CATE_SYS_HAS_PAY              @"PIN_CATE_SYS_HAS_PAY"              // 系统 - 添加的 - 支出
     #define PIN_CATE_SYS_REMOVE_PAY           @"PIN_CATE_SYS_REMOVE_PAY"           // 系统 - 删除的 - 支出
     #define PIN_CATE_CUS_HAS_PAY              @"PIN_CATE_CUS_HAS_PAY"              // 用户 - 添加的 - 支出
     #define PIN_CATE_SYS_Has_PAY_SYNCED       @"PIN_CATE_SYS_Has_PAY_SYNCED"       // 系统 - 添加的 - 支出 - 未同步(同步后应该为空)
     #define PIN_CATE_SYS_REMOVE_PAY_SYNCED    @"PIN_CATE_SYS_REMOVE_PAY_SYNCED"    // 系统 - 删除的 - 支出 - 未同步(同步后应该为空)
     #define PIN_CATE_CUS_HAS_PAY_SYNCED       @"PIN_CATE_CUS_HAS_PAY_SYNCED"       // 用户 - 添加的 - 支出 - 未同步(同步后应该为空)
     #define PIN_CATE_CUS_REMOVE_PAY_SYNCED    @"PIN_CATE_CUS_REMOVE_PAY_SYNCED"    // 用户 - 删除的 - 支出 - 未同步(同步后应该为空)
     
     // 收入
     #define PIN_CATE_SYS_HAS_INCOME              @"PIN_CATE_SYS_HAS_INCOME"              // 系统 - 添加的 - 收入
     #define PIN_CATE_SYS_REMOVE_INCOME           @"PIN_CATE_SYS_REMOVE_INCOME"           // 系统 - 删除的 - 收入
     #define PIN_CATE_CUS_HAS_INCOME              @"PIN_CATE_CUS_HAS_INCOME"              // 用户 - 添加的 - 收入
     #define PIN_CATE_SYS_Has_INCOME_SYNCED       @"PIN_CATE_SYS_Has_INCOME_SYNCED"       // 系统 - 添加的 - 收入 - 未同步(同步后应该为空)
     #define PIN_CATE_SYS_REMOVE_INCOME_SYNCED    @"PIN_CATE_SYS_REMOVE_INCOME_SYNCED"    // 系统 - 删除的 - 收入 - 未同步(同步后应该为空)
     #define PIN_CATE_CUS_HAS_INCOME_SYNCED       @"PIN_CATE_CUS_HAS_INCOME_SYNCED"       // 用户 - 添加的 - 收入 - 未同步(同步后应该为空)
     #define PIN_CATE_CUS_REMOVE_INCOME_SYNCED    @"PIN_CATE_CUS_REMOVE_INCOME_SYNCED"    // 用户 - 删除的 - 收入 - 未同步(同步后应该为空)
     
     */
    
    
    [self bendiData];
    
    
}

- (void)bendiData {
    BKCIncomeModel *model1 = [[BKCIncomeModel alloc] init];
    model1.is_income = false;
    model1.list = ({
        NSMutableArray<BKCModel *> *sysHasPayArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_HAS_PAY];
        NSMutableArray<BKCModel *> *cusHasPayArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_HAS_PAY];
        NSMutableArray<BKCModel *> *payArr = ({
            NSMutableArray *arrm = [NSMutableArray arrayWithArray:sysHasPayArr];
            [arrm addObjectsFromArray:cusHasPayArr];
            arrm = [BKCModel mj_objectArrayWithKeyValuesArray:arrm];
            arrm;
        });
        payArr;
    });
    
    BKCIncomeModel *model2 = [[BKCIncomeModel alloc] init];
    model2.is_income = true;
    model2.list = ({
        NSMutableArray<BKCModel *> *sysHasIncomeArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_SYS_HAS_INCOME];
        NSMutableArray<BKCModel *> *cusHasIncomeArr = [[PINDiskCache sharedCache] objectForKey:PIN_CATE_CUS_HAS_INCOME];
        NSMutableArray<BKCModel *> *incomeArr = ({
            NSMutableArray *arrm = [NSMutableArray arrayWithArray:sysHasIncomeArr];
            [arrm addObjectsFromArray:cusHasIncomeArr];
            arrm = [BKCModel mj_objectArrayWithKeyValuesArray:arrm];
            arrm;
        });
        incomeArr;
    });
    [self setModels:@[model1, model2]];
}


#pragma mark - 点击
- (void)rightButtonClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - 请求
// 获取我的分类
- (void)getCategoryListRequest {
    @weakify(self)
    [self.scroll createRequest:CategoryListRequest params:@{} complete:^(APPResult *result) {
        @strongify(self)
        [self setModels:[BKCIncomeModel mj_objectArrayWithKeyValuesArray:result.data]];
    }];
}
// 记账
- (void)createBookRequest:(NSString *)price mark:(NSString *)mark date:(NSDate *)date {
    NSInteger index = self.scroll.contentOffset.x / SCREEN_WIDTH;
    BKCCollection *collection = self.collections[index];
    BKCModel *cmodel = collection.model.list[collection.selectIndex.row];

    BKModel *model = [[BKModel alloc] init];
    model.Id = random() % 1000000000;
    model.price = [price floatValue];
    model.year = date.year;
    model.month = date.month;
    model.day = date.day;
    model.mark = mark;
    model.category_id = cmodel.Id;
    model.cmodel = cmodel;
    
    NSMutableArray *bookArr = [[PINDiskCache sharedCache] objectForKey:PIN_BOOK];
    NSMutableArray *bookSyncedArr = [[PINDiskCache sharedCache] objectForKey:PIN_BOOK_SYNCED];
    [bookArr addObject:model];
    [bookSyncedArr addObject:model];
    [[PINDiskCache sharedCache] setObject:bookArr forKey:PIN_BOOK];
    [[PINDiskCache sharedCache] setObject:bookArr forKey:PIN_BOOK_SYNCED];
    
    [self.navigationController dismissViewControllerAnimated:true completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NOT_BOOK_COMPLETE object:nil];
    }];
}


#pragma mark - set
- (void)setModels:(NSArray<BKCIncomeModel *> *)models {
    _models = models;
    for (int i=0; i<models.count; i++) {
        self.collections[i].model = models[i];
    }
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
// 点击导航栏
- (void)bookClickNavigation:(NSNumber *)index {
    [self.scroll setContentOffset:CGPointMake(SCREEN_WIDTH * [index integerValue], 0) animated:YES];
}
// 点击item
- (void)bookClickItem:(BKCCollection *)collection {
    NSIndexPath *indexPath = collection.selectIndex;
    BKCIncomeModel *listModel = _models[collection.tag];
    // 选择类别
    if (indexPath.row != (listModel.list.count - 1)) {
        // 显示键盘
        [self.keyboard show];
        // 刷新
        NSInteger page = _scroll.contentOffset.x / SCREEN_WIDTH;
        BKCCollection *collection = self.collections[page];
        [collection setHeight:SCREEN_HEIGHT - NavigationBarHeight - self.keyboard.height];
        [collection scrollToIndex:indexPath];
    }
    // 设置
    else {
        // 隐藏键盘
        for (BKCCollection *collection in self.collections) {
            [collection reloadSelectIndex];
            [collection setHeight:SCREEN_HEIGHT - NavigationBarHeight];
        }
        [self.keyboard hide];
        // 刷新
        CAController *vc = [[CAController alloc] init];
        [vc setIs_income:collection.tag];
        [vc setComplete:^{
//            [AFNManager POST:CategoryListRequest params:@{} complete:^(APPResult *result) {
//                [self setModels:[BKCIncomeModel mj_objectArrayWithKeyValuesArray:result.data]];
//            }];
            [self bendiData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (BKCCollection *collection in self.collections) {
        [collection reloadSelectIndex];
        [collection setHeight:SCREEN_HEIGHT - NavigationBarHeight];
    }
    [self.keyboard hide];
    [self.navigation setOffsetX:scrollView.contentOffset.x];
}


#pragma mark - get
- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:({
            CGFloat left = 0;
            CGFloat top = NavigationBarHeight;
            CGFloat width = SCREEN_WIDTH;
            CGFloat height = SCREEN_HEIGHT - NavigationBarHeight;
            CGRectMake(left, top, width, height);
        })];
        [_scroll setDelegate:self];
        [_scroll setShowsHorizontalScrollIndicator:NO];
        [_scroll setPagingEnabled:YES];
        [self.view addSubview:_scroll];
    }
    return _scroll;
}
- (BKCNavigation *)navigation {
    if (!_navigation) {
        _navigation = [BKCNavigation loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight)];
        [self.view addSubview:_navigation];
    }
    return _navigation;
}
- (NSMutableArray<BKCCollection *> *)collections {
    if (!_collections) {
        _collections = [NSMutableArray array];
        for (int i=0; i<2; i++) {
            BKCCollection *collection = [BKCCollection initWithFrame:({
                CGFloat width = SCREEN_WIDTH;
                CGFloat left = i * width;
                CGFloat height = SCREEN_HEIGHT - NavigationBarHeight;
                CGRectMake(left, 0, width, height);
            })];
            [collection setTag:i];
            [_scroll setContentSize:CGSizeMake(SCREEN_WIDTH * 2, 0)];
            [_scroll addSubview:collection];
            [_collections addObject:collection];
        }
    }
    return _collections;
}
- (BKCKeyboard *)keyboard {
    if (!_keyboard) {
        @weakify(self)
        _keyboard = [BKCKeyboard init];
        [_keyboard setComplete:^(NSString *price, NSString *mark, NSDate *date) {
            @strongify(self)
            [self createBookRequest:price mark:mark date:date];
        }];
        [self.view addSubview:_keyboard];
    }
    return _keyboard;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           BOOK_CLICK_ITEM: [self createInvocationWithSelector:@selector(bookClickItem:)],
                           BOOK_CLICK_NAVIGATION: [self createInvocationWithSelector:@selector(bookClickNavigation:)],
                           };
    }
    return _eventStrategy;
}



@end
