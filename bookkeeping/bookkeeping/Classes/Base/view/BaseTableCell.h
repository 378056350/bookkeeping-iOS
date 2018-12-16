//
//  BaseTableCell.h
//  KKTest
//
//  Created by RY on 17/6/12.
//  Copyright © 2017年 OuDa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableCell : UITableViewCell

/// 加载第一个NIB
+ (instancetype)loadFirstNib:(UITableView *)table;

/// 加载最后一个nib
+ (instancetype)loadLastNib:(UITableView *)table;

/// 从代码创建cell
+ (instancetype)loadCode:(UITableView *)table;

/// 加载指定xib
+ (instancetype)loadNib:(NSInteger)index frame:(UITableView *)table;

- (void)initUI;

@end
