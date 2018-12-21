/**
 * 记账列表
 * @author 郑业强 2018-12-21 创建文件
 */

#import "BookListModel.h"

@implementation BookModel

+ (void)load {
    [BookModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id",
                 };
    }];
}

@end


@implementation BookListModel

+ (void)load {
    [BookListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list": @"BookModel"};
    }];
}

@end
