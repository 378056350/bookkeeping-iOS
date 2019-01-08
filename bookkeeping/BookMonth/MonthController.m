/**
 * 记账
 * @author 郑业强 2019-01-08 创建文件
 */

#import "MonthController.h"
#import "ContentView.h"
#import <NotificationCenter/NotificationCenter.h>

// 获取屏幕 宽度、高度
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

#pragma mark - 声明
@interface MonthController () <NCWidgetProviding>

@property (nonatomic, strong) ContentView *month;

@end


#pragma mark - 实践
@implementation MonthController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self month];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}



#pragma mark - get
- (ContentView *)month {
    if (!_month) {
        _month = [ContentView loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        [self.view addSubview:_month];
    }
    return _month;
}


@end
