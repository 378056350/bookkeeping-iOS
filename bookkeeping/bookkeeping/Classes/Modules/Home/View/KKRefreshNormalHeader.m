//
//  KKRefreshNormalHeader.m
//  bookkeeping
//
//  Created by zhongke on 2018/12/17.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "KKRefreshNormalHeader.h"

#pragma mark - 声明
@interface KKRefreshNormalHeader()

@end


#pragma mark - 实现
@implementation KKRefreshNormalHeader


+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    KKRefreshNormalHeader *header = [super headerWithRefreshingBlock:refreshingBlock];
    [header setTitle:@"下拉查看下月数据" forState:MJRefreshStateIdle];
    [header setTitle:@"送开可查看下月数据" forState:MJRefreshStatePulling];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
    [header setTitle:@"" forState:MJRefreshStateWillRefresh];
    [header.lastUpdatedTimeLabel setHidden:YES];
    [header.arrowView setHidden:YES];
    [header setOnlyText:NO];
    return header;
}



@end
