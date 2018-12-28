/**
 * 收入/支出切换
 * @author 郑业强 2018-12-28 创建文件
 */

#import "ChartHud.h"
#import "ChartHudCell.h"

#pragma mark - 声明
@interface ChartHud()<UITableViewDelegate, UITableViewDataSource> {
    NSInteger _current;
}

@property (nonatomic, strong) UIButton *shadow;
@property (nonatomic, strong) UITableView *table;

@end


#pragma mark - 实现
@implementation ChartHud


- (void)initUI {
    _current = 0;
    [self setUserInteractionEnabled:false];
    [self setClipsToBounds:true];
    [self shadow];
    [self table];
}


#pragma mark - 动画
- (void)show {
    [UIView animateWithDuration:.2f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.shadow setAlpha:1];
        [self.table setTop:0];
    } completion:^(BOOL finished) {
        [self setUserInteractionEnabled:true];
    }];
}
- (void)hide {
    [UIView animateWithDuration:.2f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.shadow setAlpha:0];
        [self.table setTop:-countcoordinatesX(100)];
    } completion:^(BOOL finished) {
        [self setUserInteractionEnabled:false];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChartHudCell *cell = [ChartHudCell loadFirstNib:tableView];
    cell.choose = _current == indexPath.row;
    cell.indexPath = indexPath;
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    _current = indexPath.row;
    [tableView reloadData];
    [self hide];
    if (self.complete) {
        self.complete(indexPath.row);
    }
}


#pragma mark - get
- (UIButton *)shadow {
    if (!_shadow) {
        _shadow = [UIButton buttonWithType:UIButtonTypeCustom];
        _shadow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _shadow.frame = self.bounds;
        _shadow.alpha = 0;
        @weakify(self)
        [[_shadow rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
            @strongify(self)
            [self hide];
        }];
        [self addSubview:_shadow];
    }
    return _shadow;
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, -countcoordinatesX(100), SCREEN_WIDTH, countcoordinatesX(100)) style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorColor = kColor_BG;
        [self addSubview:_table];
    }
    return _table;
}


@end
