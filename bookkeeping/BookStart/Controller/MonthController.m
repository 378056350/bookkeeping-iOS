/**
 * 记账
 * @author 郑业强 2019-01-08 创建文件
 */

#import "MonthController.h"
#define PADDING 7
#define VIEW_W (CGRectGetWidth(self.view.bounds) - PADDING * 2)


#pragma mark - 声明
@interface MonthController () <NCWidgetProviding>

@property (nonatomic, strong) StartView *content;

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


#pragma mark - get
- (StartView *)content {
    if (!_content) {
        _content = [StartView loadCode:CGRectMake(0, 0, VIEW_W, 110 + VIEW_W / 5.f * 4.f)];
        [self.view addSubview:_content];
    }
    return _content;
}


@end
