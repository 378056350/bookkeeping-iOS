/**
 * 徽章model
 * @author 郑业强 2018-12-21 创建文件
 */

#import "BadgeListModel.h"


@implementation BadgeModel

+ (void)load {
    [BadgeModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id",
                 };
    }];
}

@end


@implementation BadgeListModel

+ (void)load {
    [BadgeListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list": @"BadgeModel"};
    }];
    [BadgeListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id",
                 };
    }];
}

@end



