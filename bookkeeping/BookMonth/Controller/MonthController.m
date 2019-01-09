/**
 * 记账
 * @author 郑业强 2019-01-08 创建文件
 */

#import "MonthController.h"
#import "ContentView.h"
#define PADDING 7
#define VIEW_W (CGRectGetWidth(self.view.bounds) - PADDING * 2)


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


#pragma mark - 点击
- (void)bookClick {
    [self.extensionContext openURL:[NSURL URLWithString:@"kbook://month"] completionHandler:^(BOOL success) {
        
    }];
}


#pragma mark - get
- (ContentView *)month {
    if (!_month) {
        _month = [ContentView loadFirstNib:CGRectMake(0, 0, VIEW_W, 110)];
        [_month.bookBtn addTarget:self action:@selector(bookClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_month];
    }
    return _month;
}


@end
