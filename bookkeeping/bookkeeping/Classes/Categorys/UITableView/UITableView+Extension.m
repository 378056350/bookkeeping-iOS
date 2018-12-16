//
//  UITableView+Extension.m
//  KKTest
//
//  Created by RY on 17/6/25.
//  Copyright © 2017年 OuDa. All rights reserved.
//

#import "UITableView+Extension.h"
#import <objc/runtime.h>

@implementation UITableView (Extension)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithFrame:style:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithFrame:style:));
    method_exchangeImplementations(imp, myImp);  //交换方法
    
    
    Method imp1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp1 = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp1, myImp1);  //交换方法
}

- (instancetype)myInitWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    [self myInitWithFrame:frame style:style];
    // iOS11
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    return self;
}
- (instancetype)myInitWithCoder:(NSCoder *)aDecode {
    [self myInitWithCoder:aDecode];
    // iOS11
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    return self;
}

// 隐藏多余线
- (void)lineHide {
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
// 设置tableview横线
- (void)lineAll {
    self.separatorInset = UIEdgeInsetsZero;
}
// 设置tableview横线(有间隙)
- (void)linePadding {
    self.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
}

@end
