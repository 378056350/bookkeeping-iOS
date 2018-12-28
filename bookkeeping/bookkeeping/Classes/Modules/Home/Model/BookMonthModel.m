/**
 * 月份model
 * @author 郑业强 2018-12-28 创建文件
 */

#import "BookMonthModel.h"

@implementation BookMonthModel

+ (void)load {
    [BookMonthModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id"
                 };
    }];
}

@end
