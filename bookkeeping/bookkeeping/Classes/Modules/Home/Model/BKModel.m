/**
 * 记账model
 * @author 郑业强 2018-12-31 创建文件
 */

#import "BKModel.h"


@implementation BKModel

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

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[BKModel class]]) {
        return false;
    }
    BKModel *model = object;
    if ([self Id] == [model Id] &&
        [self category_id] == [model category_id] &&
        [self price] == [model price] &&
        [self year] == [model year] &&
        [self month] == [model month] &&
        [self day] == [model day] &&
        [self mark] == [model mark] &&
        [self.cmodel isEqual:model.cmodel]) {
        return true;
    }
    return false;
}

@end



@implementation BKMonthModel

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

- (NSString *)dateStr {
    return [NSString stringWithFormat:@"%02ld月%02ld日   %@", [_date month], [_date day], [_date dayFromWeekday]];
}

- (NSString *)moneyStr {
    NSMutableString *strm = [NSMutableString string];
    if (_income != 0) {
        [strm appendFormat:@"收入: %@", [@(_income) description]];
    }
    if (_income != 0 && _pay != 0) {
        [strm appendString:@"    "];
    }
    if (_pay != 0) {
        [strm appendFormat:@"支出: %@", [@(_pay) description]];
    }
    return strm;
}

// 统计数据
+ (NSMutableArray<BKMonthModel *> *)statisticalDataWithYear:(NSInteger)year month:(NSInteger)month {
    // 根据时间过滤
    NSMutableArray<BKModel *> *bookArr = [[PINDiskCache sharedCache] objectForKey:PIN_BOOK];
    NSString *preStr = [NSString stringWithFormat:@"year == %ld AND month == %ld", year, month];
    NSPredicate *pre = [NSPredicate predicateWithFormat:preStr];
    NSMutableArray<BKModel *> *models = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
    
    // 统计数据
    NSMutableDictionary *dictm = [NSMutableDictionary dictionary];
    for (BKModel *model in models) {
        NSString *key = [NSString stringWithFormat:@"%ld-%02ld-%02ld", model.year, model.month, model.day];
        // 初始化
        if (![[dictm allKeys] containsObject:key]) {
            BKMonthModel *submodel = [[BKMonthModel alloc] init];
            submodel.list = [NSMutableArray array];
            submodel.income = 0;
            submodel.pay = 0;
            submodel.date = [NSDate dateWithYMD:key];
            [dictm setObject:submodel forKey:key];
        }
        // 添加数据
        BKMonthModel *submodel = dictm[key];
        [submodel.list addObject:model];
        // 收入
        if (model.cmodel.is_income == true) {
            [submodel setIncome:submodel.income + model.price];
        }
        // 支出
        else {
            [submodel setPay:submodel.pay + model.price];
        }
        [dictm setObject:submodel forKey:key];
    }
    
    // 排序
    NSMutableArray<BKMonthModel *> *arrm = [NSMutableArray arrayWithArray:[dictm allValues]];
    arrm = [NSMutableArray arrayWithArray:[arrm sortedArrayUsingComparator:^NSComparisonResult(BKMonthModel *obj1, BKMonthModel *obj2) {
        return [obj1.dateStr compare:obj2.dateStr];
    }]];
    return arrm;
}

@end


//@implementation BookListModel
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (!self) {
//        return nil;
//    }
//    self = [NSObject decodeClass:self decoder:aDecoder];
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [NSObject encodeClass:self encoder:aCoder];
//}
//
//@end
//
//
//@implementation BookGroupModel
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (!self) {
//        return nil;
//    }
//    self = [NSObject decodeClass:self decoder:aDecoder];
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [NSObject encodeClass:self encoder:aCoder];
//}
//
//@end
//
//
//@implementation BKModel
//
//+ (void)load {
//    [BKModel mj_setupObjectClassInArray:^NSDictionary *{
//        return @{
//                 @"list": @"BookListModel",
//                 @"group": @"BookGroupModel"
//                 };
//    }];
//}
//
//+ (instancetype)mj_objectWithKeyValues:(id)keyValues {
//    CGFloat income = 0;
//    CGFloat pay = 0;
//    BKModel *model = [super mj_objectWithKeyValues:keyValues];
//    // 列表数据
//    if (model.list.count != 0) {
//        for (BookListModel *submodel in model.list) {
//            if (submodel.is_income == 0) {
//                pay += submodel.price;
//            } else {
//                income += submodel.price;
//            }
//        }
//    }
//    // 组数据
//    else if (model.group.count != 0) {
//        for (BookGroupModel *submodel in model.list) {
//            if (submodel.is_income == 0) {
//                pay += submodel.price;
//            } else {
//                income += submodel.price;
//            }
//        }
//    }
//    // 收入
//    model.income = income;
//    // 支出
//    model.pay = pay;
//    // 整理列表数据
//    model.listSorts = ({
//        NSMutableArray<NSMutableArray<BookListModel *> *> *lists = [NSMutableArray array];
//        if (model.list.count != 0) {
//            [lists addObject:[NSMutableArray array]];
//            NSInteger day = model.list[0].day;
//            for (BookListModel *submodel in model.list) {
//                if (submodel.day == day) {
//                    [[lists lastObject] addObject:submodel];
//                } else {
//                    day = submodel.day;
//                    [lists addObject:[NSMutableArray array]];
//                    [[lists lastObject] addObject:submodel];
//                }
//                if (submodel.is_income == 0) {
//                    pay += submodel.price;
//                } else {
//                    income += submodel.price;
//                }
//            }
//        }
//        lists;
//    });
//    return model;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (!self) {
//        return nil;
//    }
//    self = [NSObject decodeClass:self decoder:aDecoder];
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [NSObject encodeClass:self encoder:aCoder];
//}

//@end
