/**
 * 月份model
 * @author 郑业强 2018-12-28 创建文件
 */

#import "HomeListModel.h"

@implementation HomeListModel

+ (void)load {
    [HomeListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id"
                 };
    }];
}


/**
 * @[数据,数据,数据,数据]
 * 转换为:
 {
 "pay": 支出
 "income": 收入
 "data": 数据
 }
 */

+ (NSDictionary *)createGroupWithList:(NSMutableArray<HomeListModel *> *)datas {
    CGFloat income = 0;
    CGFloat pay = 0;
    NSMutableArray<NSMutableArray<HomeListModel *> *> *arrm = [NSMutableArray array];
    if (datas.count != 0) {
        [arrm addObject:[NSMutableArray array]];
        NSInteger day = datas[0].day;
        for (HomeListModel *model in datas) {
            if (model.day == day) {
                [[arrm lastObject] addObject:model];
            } else {
                day = model.day;
                [arrm addObject:[NSMutableArray array]];
                [[arrm lastObject] addObject:model];
            }
            if (model.is_income == 0) {
                pay += model.price;
            } else {
                income += model.price;
            }
        }
    }
    
    NSDictionary *param = @{@"pay": @(pay), @"income": @(income), @"data": arrm};
    
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           @"pay", [NSNumber numberWithFloat:pay],
//                           @"income", [NSNumber numberWithFloat:income],
//                           @"data", arrm, nil];
    return param;
}


@end
