//
//  UIResponder+QFEventHandle.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (QFEventHandle)

/**
 通过事件响应链条传递事件
 
 @param eventName 事件名
 @param data 附加参数
 */
- (void)routerEventWithName:(NSString *)eventName data:(id)data;

/**
 通过方法SEL生成NSInvocation
 
 @param selector 方法
 @return Invocation对象
 */
- (NSInvocation *)createInvocationWithSelector:(SEL)selector;

@end
