/**
 * 记账
 * @author 郑业强 2018-12-16 创建文件
 */

#import "MineController.h"
#import "MineView.h"
#import "BadgeController.h"
#import "CategoryController.h"
#import "MINE_EVENT_MANAGER.h"


#pragma mark - 声明
@interface MineController()

@property (nonatomic, strong) MineView *mine;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation MineController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:YES];
    [self mine];
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
- (void)mineCellClick:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BadgeController *vc = [[BadgeController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CategoryController *vc = [[CategoryController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


#pragma mark - get
- (MineView *)mine {
    if (!_mine) {
        _mine = [MineView loadCode:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabbarHeight)];
        [self.view addSubview:_mine];
    }
    return _mine;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           MINE_CELL_CLICK: [self createInvocationWithSelector:@selector(mineCellClick:)],
                           
                           };
    }
    return _eventStrategy;
}


@end
