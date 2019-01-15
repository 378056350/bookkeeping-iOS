/**
 * Cell
 * @author 郑业强 2019-01-15 创建文件
 */

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)


// 设置点击颜色
- (void)setSelectBackgroundColor:(UIColor *)color {
    UIView *view_bg = [[UIView alloc] initWithFrame:self.frame];
    view_bg.backgroundColor = color;
    self.selectedBackgroundView = view_bg;
}

// 加载第一个nib
+ (instancetype)loadFirstNib:(UITableView *)table {
    UITableViewCell *cell = [self loadNib:0 frame:table];
    [cell initUI];
    return cell;
}

// 加载最后一个nib
+ (instancetype)loadLastNib:(UITableView *)table {
    NSInteger index = [self getCells].count - 1;
    UITableViewCell *cell = [self loadNib:index frame:table];
    [cell initUI];
    return cell;
}

// 从代码创建cell
+ (instancetype)loadCode:(UITableView *)table {
    NSString *name = NSStringFromClass(self);
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:name];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
    }
    [cell setSelectBackgroundColor:kColor_Line_Color];
    [cell initUI];
    return cell;
}

// 加载指定nib
+ (instancetype)loadNib:(NSInteger)index frame:(UITableView *)table {
    NSString *name = NSStringFromClass(self);
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:name];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil][index];
    }
    [cell setSelectBackgroundColor:kColor_Line_Color];
    [cell initUI];
    return cell;
}

// 获取XIB中cell个数
+ (NSArray *)getCells {
    NSString *name = NSStringFromClass(self);
    return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
}

// 初始化
- (void)initUI {
    
}


@end
