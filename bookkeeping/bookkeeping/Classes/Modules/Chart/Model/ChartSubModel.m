//
//  ChartSubModel.m
//  bookkeeping
//
//  Created by zhongke on 2018/12/29.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "ChartSubModel.h"

@implementation ChartSubModel

+ (instancetype)init {
    ChartSubModel *model = [[ChartSubModel alloc] init];
    model.year = -1;
    model.month = -1;
    model.day = -1;
    model.week = -1;
    return model;
}

- (NSString *)detail {
    NSDate *date = [NSDate date];
    // 周
    if (_selectIndex == 0) {
        if ([date weekOfYear] == _week && [date year] == _year) {
            return @"本周";
        } else if (([date weekOfYear] - 1) == _week && [date year] == _year) {
            return @"上周";
        } else if ([date year] == _year) {
            return [NSString stringWithFormat:@"%02ld周", _week];
        } else {
            return [NSString stringWithFormat:@"%ld-%02ld周", _year, _week];
        }
    }
    // 月
    else if (_selectIndex == 1) {
        if ([date month] == _month && [date year] == _year) {
            return @"本月";
        } else if (([date month] - 1) == _month && [date year] == _year) {
            return @"上月";
        } else if ([date year] == _year) {
            return [NSString stringWithFormat:@"%02ld月", _month];
        } else {
            return [NSString stringWithFormat:@"%ld-%02ld月", _year, _month];
        }
    }
    // 年
    else if (_selectIndex == 2) {
        if ([date year] == _year) {
            return @"今年";
        } else if (([date year] - 1) == _year) {
            return @"去年";
        } else {
            return [NSString stringWithFormat:@"%ld年", _year];
        }
    }
    return @"";
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[ChartSubModel class]]) {
        ChartSubModel *model = (ChartSubModel *)object;
        if (_year == model.year && _month == model.month && _day == model.day) {
            return true;
        }
        return false;
    }
    return false;
}

@end
