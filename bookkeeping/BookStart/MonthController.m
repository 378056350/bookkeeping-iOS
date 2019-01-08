/**
 * 记账
 * @author 郑业强 2019-01-08 创建文件
 */

#import "MonthController.h"
#import <NotificationCenter/NotificationCenter.h>

#pragma mark - 声明
@interface MonthController () <NCWidgetProviding>

@end


#pragma mark - 实践
@implementation MonthController


- (void)viewDidLoad {
    [super viewDidLoad];
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
        // 最多显示屏高
        self.preferredContentSize = CGSizeMake(0, 300);
    }
}




@end
