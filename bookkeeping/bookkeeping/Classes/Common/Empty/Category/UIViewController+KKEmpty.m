//
//  UIViewController+KKEmpty.m
//  imiss-ios-master
//
//  Created by zhongke on 2018/10/24.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UIViewController+KKEmpty.h"

@implementation UIViewController (KKEmpty)

#pragma mark - tool
- (void)showEmpty:(KKEmptyStatus)status {
    [self.view showEmpty:status];
}
- (void)showEmpty:(KKEmptyStatus)status complete:(KKEmptyClick)click {
    [self.view showEmpty:status complete:click];
}
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame {
    [self.view showEmpty:status frame:frame];
}
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame complete:(KKEmptyClick)click {
    [self.view showEmpty:status frame:frame complete:click];
}
- (void)showEmpty:(KKEmptyStatus)status hasBack:(BOOL)hasBack {
    [self.view showEmpty:status hasBack:hasBack];
}
- (void)showEmpty:(KKEmptyStatus)status hasBack:(BOOL)hasBack complete:(KKEmptyClick)click {
    [self showEmpty:status hasBack:hasBack complete:click];
}
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame hasBack:(BOOL)hasBack {
    [self showEmpty:status frame:frame hasBack:hasBack];
}
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame hasBack:(BOOL)hasBack complete:(KKEmptyClick)click {
    [self.view showEmpty:status frame:frame hasBack:hasBack complete:click];
}

- (void)hideEmpty {
    [self.view hideEmpty];
}

@end
