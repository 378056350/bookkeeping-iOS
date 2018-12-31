/**
 * 类别设置
 * @author 郑业强 2018-12-21 创建文件
 */

#import "CategoryListModel.h"

@implementation CategoryListModel

+ (void)load {
    [CategoryListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"insert": @"BKCModel",
                 @"remove": @"BKCModel"
                 };
    }];
}

@end
