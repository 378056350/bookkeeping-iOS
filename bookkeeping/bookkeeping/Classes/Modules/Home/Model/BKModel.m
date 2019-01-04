/**
 * 记账model
 * @author 郑业强 2018-12-31 创建文件
 */

#import "BKModel.h"


@implementation BookListModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self = [NSObject decodeClass:self decoder:aDecoder];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [NSObject encodeClass:self encoder:aCoder];
}

@end


@implementation BookGroupModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self = [NSObject decodeClass:self decoder:aDecoder];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [NSObject encodeClass:self encoder:aCoder];
}

@end


@implementation BKModel

+ (void)load {
    [BKModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list": @"BookListModel",
                 @"group": @"BookGroupModel"
                 };
    }];
}

+ (instancetype)mj_objectWithKeyValues:(id)keyValues {
    CGFloat income = 0;
    CGFloat pay = 0;
    BKModel *model = [super mj_objectWithKeyValues:keyValues];
    // 列表数据
    if (model.list.count != 0) {
        for (BookListModel *submodel in model.list) {
            if (submodel.is_income == 0) {
                pay += submodel.price;
            } else {
                income += submodel.price;
            }
        }
    }
    // 组数据
    else if (model.group.count != 0) {
        for (BookGroupModel *submodel in model.list) {
            if (submodel.is_income == 0) {
                pay += submodel.price;
            } else {
                income += submodel.price;
            }
        }
    }
    // 收入
    model.income = income;
    // 支出
    model.pay = pay;
    // 整理列表数据
    model.listSorts = ({
        NSMutableArray<NSMutableArray<BookListModel *> *> *lists = [NSMutableArray array];
        if (model.list.count != 0) {
            [lists addObject:[NSMutableArray array]];
            NSInteger day = model.list[0].day;
            for (BookListModel *submodel in model.list) {
                if (submodel.day == day) {
                    [[lists lastObject] addObject:submodel];
                } else {
                    day = submodel.day;
                    [lists addObject:[NSMutableArray array]];
                    [[lists lastObject] addObject:submodel];
                }
                if (submodel.is_income == 0) {
                    pay += submodel.price;
                } else {
                    income += submodel.price;
                }
            }
        }
        lists;
    });
    return model;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self = [NSObject decodeClass:self decoder:aDecoder];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [NSObject encodeClass:self encoder:aCoder];
}

@end
