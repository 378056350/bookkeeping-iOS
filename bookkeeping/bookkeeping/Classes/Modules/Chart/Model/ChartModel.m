/**
 * 图表
 * @author 郑业强 2018-12-29 创建文件
 */

#import "ChartModel.h"

@implementation ChartModel

+ (void)load {
    [ChartModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list": @"ChartBKCModel"};
    }];
}

@end
