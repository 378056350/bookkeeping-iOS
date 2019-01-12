/**
 * 记账详情页
 * @author 郑业强 2019-01-05 创建
 */

#import "BDController.h"
#import "BDHeader.h"
#import "BDTable.h"
#import "BDBottom.h"
#import "BD_EVENT.h"

#pragma mark - 声明
@interface BDController()

@property (nonatomic, strong) BDHeader *header;
@property (nonatomic, strong) BDTable *table;
@property (nonatomic, strong) BDBottom *bottom;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation BDController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:true];
    [self.rightButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"分享" forState:UIControlStateHighlighted];
    [self.rightButton setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.rightButton setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.rightButton setHidden:NO];
    [self header];
    [self bottom];
    [self table];
    [self monitorNotification];
}

// 监听通知
- (void)monitorNotification {
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOT_BOOK_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *x) {
        @strongify(self)
        BKModel *model = x.object;
        [self setModel:model];
    }];
    
}


#pragma mark - set
- (void)setModel:(BKModel *)model {
    _model = model;
    self.header.model = model;
    self.table.model = model;
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


#pragma mark - 点击
// 点击按钮
- (void)bdBottomClick:(NSNumber *)number {
    // 编辑
    if ([number integerValue] == 0) {
        BKCController *vc = [[BKCController alloc] init];
        vc.model = _model;
        [self.navigationController pushViewController:vc animated:true];
    }
    // 删除
    else if ([number integerValue] == 1) {
        // 删除
        NSMutableArray<BKModel *> *bookArrm = [NSUserDefaults objectForKey:PIN_BOOK];
        NSMutableArray<BKModel *> *bookSyncedArrm = [NSUserDefaults objectForKey:PIN_BOOK_SYNCED];
        if ([bookSyncedArrm containsObject:_model]) {
            [bookSyncedArrm removeObject:_model];
        }
        [bookArrm removeObject:_model];
        [NSUserDefaults setObject:bookArrm forKey:PIN_BOOK];
        [NSUserDefaults setObject:bookArrm forKey:PIN_BOOK_SYNCED];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOT_BOOK_DELETE object:nil];
        
        // 返回
        [self.navigationController popViewControllerAnimated:true];
        
        // 回调
        if (self.complete) {
            self.complete();
        }
    }
}


#pragma mark - get
- (BDHeader *)header {
    if (!_header) {
        _header = [BDHeader loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + 64)];
        [self.view addSubview:_header];
    }
    return _header;
}
- (BDTable *)table {
    if (!_table) {
        _table = [[BDTable alloc] initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _bottom.height - _header.height) style:UITableViewStylePlain];
        [self.view addSubview:_table];
    }
    return _table;
}
- (BDBottom *)bottom {
    if (!_bottom) {
        _bottom = [BDBottom loadFirstNib:({
            CGFloat height = countcoordinatesX(50) + SafeAreaBottomHeight;
            CGRectMake(0, SCREEN_HEIGHT - height, SCREEN_WIDTH, height);
        })];
        [self.view addSubview:_bottom];
    }
    return _bottom;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           BD_BOTTOM_CLICK: [self createInvocationWithSelector:@selector(bdBottomClick:)],
                           
                           };
    }
    return _eventStrategy;
}


@end
