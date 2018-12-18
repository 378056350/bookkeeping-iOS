/**
 * 定时
 * @author 郑业强 2018-12-18 创建文件
 */

#import "TIController.h"
#import "TITableView.h"
#import "BottomButton.h"

#pragma mark - 声明
@interface TIController()

@property (nonatomic, strong) TITableView *table;
@property (nonatomic, strong) BottomButton *bottom;

@end

#pragma mark - 实现
@implementation TIController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"定时提醒"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self table];
    [self bottom];
    [self.view bringSubviewToFront:self.bottom];
}

#pragma mark - get
- (TITableView *)table {
    if (!_table) {
        _table = [TITableView initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - self.bottom.height)];
        [self.view addSubview:_table];
    }
    return _table;
}
- (BottomButton *)bottom {
    if (!_bottom) {
        _bottom = [BottomButton initWithFrame:({
            CGFloat height = countcoordinatesX(50) + SafeAreaBottomHeight;
            CGFloat top = SCREEN_HEIGHT - height;
            CGRectMake(0, top, SCREEN_WIDTH, height);
        })];
        [_bottom setName:@"添加提醒"];
        [self.view addSubview:_bottom];
    }
    return _bottom;
}


@end
