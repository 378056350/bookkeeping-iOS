//
//  ChartRangeModel.m
//  bookkeeping
//
//  Created by zhongke on 2018/12/29.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "ChartRangeModel.h"

@implementation ChartRangeModel

- (NSString *)min_date_str {
    NSInteger year = _min_year;
    NSInteger month = _min_month == -1 ? 1: _min_month;
    NSInteger day = _min_day == -1 ? 1: _min_day;
    NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld", year, month, day];
    return date;
}
- (NSString *)max_date_str {
    NSInteger year = _max_year;
    NSInteger month = _max_month == -1 ? 1: _max_month;
    NSInteger day = _max_day == -1 ? 1: _max_day;
    NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld", year, month, day];
    return date;
}

- (NSDate *)min_date {
    NSString *min_date = self.min_date_str;
    return [NSDate dateWithYMD:min_date];
}
- (NSDate *)max_date {
    NSString *max_date = self.max_date_str;
    return [NSDate dateWithYMD:max_date];
}


@end
