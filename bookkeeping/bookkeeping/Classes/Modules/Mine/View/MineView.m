/**
 * 我的
 * @author 郑业强 2018-12-16 创建文件
 */


#import "MineView.h"
#import "MineTableView.h"
#import "MineHeader.h"


#pragma mark - 声明
@interface MineView()

@property (nonatomic, strong) MineHeader *header;
@property (nonatomic, strong) MineTableView *table;

@end


#pragma mark - 实现
@implementation MineView


- (void)initUI {
    [self table];
    [self header];
}


#pragma mark - get
- (MineHeader *)header {
    if (!_header) {
        _header = [MineHeader loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight)];
        [self addSubview:_header];
    }
    return _header;
}
- (MineTableView *)table {
    if (!_table) {
        _table = [MineTableView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabbarHeight)];
        [_table setSeparatorColor:kColor_BG];
        [self addSubview:_table];
    }
    return _table;
}



@end
