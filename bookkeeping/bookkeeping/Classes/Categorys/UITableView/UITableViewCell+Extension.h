//
//  UITableViewCell+Extension.h
//  bookkeeping
//
//  Created by zhongke on 2018/12/20.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Extension)

/// 加载第一个NIB
+ (instancetype)loadFirstNib:(UITableView *)table;

/// 加载最后一个nib
+ (instancetype)loadLastNib:(UITableView *)table;

/// 从代码创建cell
+ (instancetype)loadCode:(UITableView *)table;

/// 加载指定xib
+ (instancetype)loadNib:(NSInteger)index frame:(UITableView *)table;

@end

NS_ASSUME_NONNULL_END
