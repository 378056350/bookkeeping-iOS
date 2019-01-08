/**
 * 记账
 * @author 郑业强 2019-01-08 创建文件
 */

#import "MonthController.h"
#import "ContentView.h"


#pragma mark - 声明
@interface MonthController () <NCWidgetProviding>

@property (nonatomic, strong) ContentView *month;

@end


#pragma mark - 实践
@implementation MonthController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self month];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}


#pragma mark - 点击
- (void)bookClick {
    [self.extensionContext openURL:[NSURL URLWithString:@"kbook://month"] completionHandler:^(BOOL success) {
        
    }];
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"123"];
    NSLog(@"12");
    // 数据
    NSMutableArray *arr = [[PINCacheManager sharedManager] objectForKey:PIN_BOOK];
    NSLog(@"123");
    
}


#pragma mark - get
- (ContentView *)month {
    if (!_month) {
        _month = [ContentView loadFirstNib:self.view.bounds];
        [_month.bookBtn addTarget:self action:@selector(bookClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_month];
    }
    return _month;
}


@end
