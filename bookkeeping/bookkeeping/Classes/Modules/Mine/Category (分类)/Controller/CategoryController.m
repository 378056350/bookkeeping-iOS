/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "CategoryController.h"
#import "CategoryHeader.h"
#import "CategoryTable.h"
#import "BottomButton.h"
#import "ACAController.h"
#import "CATEGORY_EVENT.h"


#pragma mark - 声明
@interface CategoryController()

@property (nonatomic, strong) CategoryHeader *header;
@property (nonatomic, strong) CategoryTable *table;
@property (nonatomic, strong) BottomButton *bootom;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation CategoryController


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
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - get
- (CategoryHeader *)header {
    if (!_header) {
        _header = [CategoryHeader loadFirstNib:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, countcoordinatesX(50))];
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
                           };
    }
    return _eventStrategy;
}


@end
