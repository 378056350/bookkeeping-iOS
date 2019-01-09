/**
 * 记账
 * @author 郑业强 2019-01-08 创建文件
 */

#import "MonthController.h"
#import "START_EVENT.h"
#define PADDING 7
#define VIEW_W (CGRectGetWidth(self.view.bounds) - PADDING * 2)


#pragma mark - 声明
@interface MonthController () <NCWidgetProviding>

@property (nonatomic, strong) StartView *content;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实践
@implementation MonthController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self content];
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
        self.preferredContentSize = CGSizeMake(0, 110);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake(0, 110);
    } else {
        self.preferredContentSize = CGSizeMake(0, 110 + VIEW_W / 5.f * 4.f);
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
// 记账完成
- (void)startBook:(id)data {
    // 打开APP
    [self.extensionContext openURL:[NSURL URLWithString:@"kbook://book"] completionHandler:^(BOOL success) {
        
    }];
}



#pragma mark - get
- (StartView *)content {
    if (!_content) {
        _content = [StartView loadCode:CGRectMake(0, 0, VIEW_W, 110 + VIEW_W / 5.f * 4.f)];
        [self.view addSubview:_content];
    }
    return _content;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           START_SEG_BOOK: [self createInvocationWithSelector:@selector(startBook:)]
                           };
    }
    return _eventStrategy;
}


@end
