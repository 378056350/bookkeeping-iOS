//
//  RequestTipRefreshFooter.m
//  ZhongLv
//
//  Created by zhongke on 2018/11/29.
//  Copyright © 2018年 iOSlmm. All rights reserved.
//

#import "RequestTipRefreshFooter.h"

@implementation RequestTipRefreshFooter


+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    RequestTipRefreshFooter *footer = [super footerWithRefreshingBlock:refreshingBlock];
    [[footer valueForKey:@"loadingView"] setHidden:YES];
    [[footer valueForKey:@"loadingView"] setAlpha:0];
    [footer.stateLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [footer.stateLabel setTextColor:kColor_Text_Black];
    return footer;
}
- (void)setName:(NSString *)name {
    _name = name;
    [self setTitle:name forState:MJRefreshStateIdle];
    [self setTitle:name forState:MJRefreshStatePulling];
    [self setTitle:name forState:MJRefreshStateRefreshing];
    [self setTitle:name forState:MJRefreshStateWillRefresh];
    [self setTitle:name forState:MJRefreshStateNoMoreData];
}


@end
