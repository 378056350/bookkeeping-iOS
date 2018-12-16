//
//  BaseTableView.m
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/15.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseTableView.h"

#pragma mark - 声明
@interface BaseTableView()

@end

#pragma mark - 实现
@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self initUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
}

@end
