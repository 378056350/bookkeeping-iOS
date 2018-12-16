//
//  UIResponder+QFEventHandle.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "UIResponder+QFEventHandle.h"

@implementation UIResponder (QFEventHandle)


/**
 通过事件响应链条传递事件

 @param eventName 事件名
 @param userInfo 附加参数
 */
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    [[self nextResponder] routerEventWithName:eventName data:data];
}

/**
 通过方法SEL生成NSInvocation

 @param selector 方法
 @return Invocation对象
 */
- (NSInvocation *)createInvocationWithSelector:(SEL)selector {
    //通过方法名创建方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    //创建invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    return invocation;
}

@end
