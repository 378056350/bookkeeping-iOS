//
//  KKRefreshNormalFooter.m
//  bookkeeping
//
//  Created by zhongke on 2018/12/28.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "KKRefreshNormalFooter.h"

@implementation KKRefreshNormalFooter

+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    KKRefreshNormalFooter *footer = [super footerWithRefreshingBlock:refreshingBlock];
    return footer;
}

@end
