//
//  NSMutableArray+Extension.h
//  bookkeeping
//
//  Created by zhongke on 2019/1/15.
//  Copyright © 2019年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Extension)

/// 过滤数据
+ (NSMutableArray *)kk_filteredArrayUsingPredicate:(NSString *)fotmat array:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
