//
//  KKRefreshGifHeader.m
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/14.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "KKRefreshGifHeader.h"

#pragma mark - 声明
@interface KKRefreshGifHeader()

@end

#pragma mark - 实现
@implementation KKRefreshGifHeader

// 基本设置
- (void)prepare {
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];

//    [self setTitle:@"" forState:MJRefreshStateIdle];
//    [self setTitle:@"" forState:MJRefreshStatePulling];
//    [self setTitle:@"" forState:MJRefreshStateRefreshing];
    
    // 隐藏状态和时间
    [self.stateLabel setHidden:YES];
    [self.lastUpdatedTimeLabel setHidden:YES];
}

@end
