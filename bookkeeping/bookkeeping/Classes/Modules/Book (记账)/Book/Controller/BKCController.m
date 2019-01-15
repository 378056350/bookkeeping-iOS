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
    
    
    
    [self bendiData];
    
    
    if (_model) {
        dispatch_async(dispatch_get_main_queue(), ^{        
            BOOL is_income = self.model.cmodel.is_income;
            [self.scroll setContentOffset:CGPointMake(SCREEN_WIDTH * is_income, 0) animated:false];
            [self.navigation setOffsetX:self.scroll.contentOffset.x];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                BKCCollection *collection = self.collections[is_income];
                NSMutableArray *arrm = [NSMutableArray array];
                if (is_income == false) {
                    [arrm addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_SYS_HAS_PAY]];
                    [arrm addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_PAY]];
                } else {
                    [arrm addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_SYS_HAS_INCOME]];
                    [arrm addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_INCOME]];
                }
                [collection setSelectIndex:[NSIndexPath indexPathForRow:[arrm indexOfObject:self.model.cmodel] inSection:0]];
                [collection reloadData];
                [self bookClickItem:collection];
                [self.keyboard setModel:self.model];
            });
        });
    }
    
}

- (void)bendiData {
    BKCIncomeModel *model1 = [[BKCIncomeModel alloc] init];
    model1.is_income = false;
    model1.list = ({
        NSMutableArray<BKCModel *> *sysHasPayArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_HAS_PAY];
        NSMutableArray<BKCModel *> *cusHasPayArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_PAY];
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
        NSMutableArray<BKCModel *> *sysHasIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_SYS_HAS_INCOME];
        NSMutableArray<BKCModel *> *cusHasIncomeArr = [NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_INCOME];
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
    
    model.Id = [[BKModel getId] integerValue];
    model.price = [[NSDecimalNumber decimalNumberWithString:price] doubleValue];
    model.year = date.year;
    model.month = date.month;
    model.day = date.day;
    model.mark = mark;
    model.category_id = cmodel.Id;
    model.cmodel = cmodel;
    
    // 新增
    if (!_model) {
        
        NSMutableArray *bookArr = [NSUserDefaults objectForKey:PIN_BOOK];
        NSMutableArray *bookSyncedArr = [NSUserDefaults objectForKey:PIN_BOOK_SYNCED];
        [bookArr addObject:model];
        [bookSyncedArr addObject:model];
        [NSUserDefaults setObject:bookArr forKey:PIN_BOOK];
        [NSUserDefaults setObject:bookArr forKey:PIN_BOOK_SYNCED];
    }
    // 修改
    else {
        _model.price = [price floatValue];
        _model.year = date.year;
        _model.month = date.month;
        _model.day = date.day;
        _model.mark = mark;
        _model.category_id = cmodel.Id;
        _model.cmodel = cmodel;
        model = _model;
        
        NSMutableArray *bookArr = [NSUserDefaults objectForKey:PIN_BOOK];
        NSMutableArray *bookSyncedArr = [NSUserDefaults objectForKey:PIN_BOOK_SYNCED];
        NSInteger index = [bookArr indexOfObject:model];
        [bookArr replaceObjectAtIndex:index withObject:model];
        if ([bookSyncedArr containsObject:model]) {
            [bookSyncedArr replaceObjectAtIndex:index withObject:model];
        }
        [NSUserDefaults setObject:bookArr forKey:PIN_BOOK];
        [NSUserDefaults setObject:bookArr forKey:PIN_BOOK_SYNCED];
    }
    
    
    if (self.navigationController.viewControllers.count != 1) {
        [self.navigationController popViewControllerAnimated:true];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOT_BOOK_COMPLETE object:model];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOT_BOOK_COMPLETE object:model];
        }];
    }
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
