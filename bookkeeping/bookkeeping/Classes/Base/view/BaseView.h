//
//  BaseView.h
//  KKTest
//
//  Created by RY on 17/6/12.
//  Copyright © 2017年 OuDa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

//==================================== 加载 ====================================//
/// 加载第一个nib
+ (instancetype)loadFirstNib:(CGRect)frame;

/// 加载最后一个nib
+ (instancetype)loadLastNib:(CGRect)frame;

/// 从代码创建view
+ (instancetype)loadCode:(CGRect)frame;

/// 加载指定nib
+ (instancetype)loadNib:(NSInteger)index frame:(CGRect)frame;

/// 初始化UI
- (void)initUI;

@end
