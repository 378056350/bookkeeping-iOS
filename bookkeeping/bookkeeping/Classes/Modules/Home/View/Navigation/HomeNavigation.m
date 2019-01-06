//
//  HomeNavigation.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/1/6.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "HomeNavigation.h"

#pragma mark - 声明
@interface HomeNavigation()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintT;

@end


#pragma mark - 实现
@implementation HomeNavigation


- (void)initUI {
    [self setBackgroundColor:kColor_Main_Color];
    [self.iconConstraintT setConstant:StatusBarHeight];
}


@end
