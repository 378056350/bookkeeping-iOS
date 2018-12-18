//
//  BaseView+Popup.m
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/21.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseView+Popup.h"
#import <objc/runtime.h>

static void *popup_value;

@implementation BaseView (Popup)

- (void)setPopup:(KKPopup *)popup {
    objc_setAssociatedObject(self, &popup_value, popup, OBJC_ASSOCIATION_ASSIGN);
}
- (KKPopup *)popup {
    UIView *view = [self superview];
    if ([view isKindOfClass:[KKPopup class]]) {
        return objc_getAssociatedObject(self, &popup_value);
    }
    return nil;
}

@end
