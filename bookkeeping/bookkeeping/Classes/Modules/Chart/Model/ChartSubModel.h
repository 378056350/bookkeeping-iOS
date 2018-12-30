//
//  ChartSubModel.h
//  bookkeeping
//
//  Created by zhongke on 2018/12/29.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartSubModel : BaseModel

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger week_day;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) NSInteger selectIndex;

+ (instancetype)init;

@end

NS_ASSUME_NONNULL_END
