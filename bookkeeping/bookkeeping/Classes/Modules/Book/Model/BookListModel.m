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

+ (BookModel *)createSetModel {
    BookModel *set = [[BookModel alloc] init];
    set.Id = 0;
    set.name = @"设置";
    set.icon_n = @"book/cc_home_tools@3x.png";
    set.icon_l = @"book/cc_home_tools_l@3x.png";
    set.icon_s = @"book/cc_home_tools_s@3x.png";
    set.is_system = true;
    return set;
}

@end


@implementation BookListModel

+ (void)load {
    [BookListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list": @"BookModel"};
    }];
}

@end
