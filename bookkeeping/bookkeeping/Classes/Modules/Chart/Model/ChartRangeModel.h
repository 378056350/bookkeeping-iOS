//
//  ChartRangeModel.h
//  bookkeeping
//
//  Created by zhongke on 2018/12/29.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartRangeModel : BaseModel

@property (nonatomic, assign) NSInteger min_year;
@property (nonatomic, assign) NSInteger min_month;
@property (nonatomic, assign) NSInteger min_day;
@property (nonatomic, assign) NSInteger min_week;
@property (nonatomic, assign) NSInteger min_week_day;
@property (nonatomic, assign) NSInteger min_week_year;
@property (nonatomic, assign) NSInteger max_year;
@property (nonatomic, assign) NSInteger max_month;
@property (nonatomic, assign) NSInteger max_day;
@property (nonatomic, assign) NSInteger max_week;
@property (nonatomic, assign) NSInteger max_week_day;
@property (nonatomic, assign) NSInteger max_week_year;

@end

NS_ASSUME_NONNULL_END
