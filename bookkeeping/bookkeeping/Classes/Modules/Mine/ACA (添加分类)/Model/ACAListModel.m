/**
 * 新增分类列表
 * @author 郑业强 2018-12-21 创建文件
 */

#import "ACAListModel.h"


@implementation ACAModel

+ (void)load {
    [ACAModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id",
                 };
    }];
}

@end


@implementation ACAListModel

+ (void)load {
    [ACAListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list": @"ACAModel"};
    }];
    [ACAListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id",
                 };
    }];
}

@end
