//
//  UIView+KKEmpty.m
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/23.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UIView+KKEmpty.h"
#import <objc/runtime.h>

static void *empty_view;

@implementation UIView (KKEmpty)


#pragma mark - get
- (void)setEmpty:(KKEmpty *)empty {
    objc_setAssociatedObject(self, &empty_view, empty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (KKEmpty *)empty {
    if (!objc_getAssociatedObject(self, &empty_view)) {
        KKEmpty *empty = [KKEmpty initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [empty setHidden:YES];
        [empty setUserInteractionEnabled:NO];
        [self addSubview:empty];
        [self setEmpty:empty];
    }
    return objc_getAssociatedObject(self, &empty_view);
}


#pragma mark - tool
- (void)showEmpty:(KKEmptyStatus)status {
    [self showEmpty:status frame:self.bounds complete:nil];
}
- (void)showEmpty:(KKEmptyStatus)status hasBack:(BOOL)hasBack {
    [self showEmpty:status hasBack:hasBack complete:nil];
}
- (void)showEmpty:(KKEmptyStatus)status complete:(KKEmptyClick)click {
    [self showEmpty:status frame:self.bounds complete:click];
}
- (void)showEmpty:(KKEmptyStatus)status hasBack:(BOOL)hasBack complete:(KKEmptyClick)click {
    [self showEmpty:status frame:self.bounds hasBack:hasBack complete:click];
}
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame {
    [self showEmpty:status frame:frame complete:nil];
}
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame hasBack:(BOOL)hasBack {
    [self showEmpty:status frame:frame hasBack:hasBack complete:nil];
}
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame complete:(KKEmptyClick)click {
    [self showEmpty:status frame:frame hasBack:NO complete:click];
}
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame hasBack:(BOOL)hasBack complete:(KKEmptyClick)click {
    self.empty.frame = frame;
    self.empty.userInteractionEnabled = YES;
    self.empty.hidden = NO;
    self.empty.status = status;
    self.empty.click = click;
    self.empty.hasBack = hasBack;
}
- (void)hideEmpty {
    [self.empty setHidden:YES];
    [self.empty setUserInteractionEnabled:NO];
}


@end
