/**
 * Cell
 * @author 郑业强 2019-01-15 创建文件
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Extension)


/// 设置点击颜色
- (void)setSelectBackgroundColor:(UIColor *)color;

/// 加载第一个NIB
+ (instancetype)loadFirstNib:(UITableView *)table;

/// 加载最后一个nib
+ (instancetype)loadLastNib:(UITableView *)table;

/// 从代码创建cell
+ (instancetype)loadCode:(UITableView *)table;

/// 加载指定xib
+ (instancetype)loadNib:(NSInteger)index frame:(UITableView *)table;

/// 初始化
- (void)initUI;


@end

NS_ASSUME_NONNULL_END
