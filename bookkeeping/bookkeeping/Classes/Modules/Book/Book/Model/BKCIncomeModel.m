/**
 * 记账列表
 * @author 郑业强 2018-12-21 创建文件
 */

#import "BKCIncomeModel.h"

@implementation BKCModel

+ (void)load {
    [BKCModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Id": @"id",
                 };
    }];
}

+ (BKCModel *)createSetModel {
    BKCModel *set = [[BKCModel alloc] init];
    set.Id = 0;
    set.name = @"设置";
    set.icon_n = @"cc_home_tools.png";
    set.icon_l = @"cc_home_tools_l.png";
    set.icon_s = @"cc_home_tools_s.png";
    set.is_system = true;
    return set;
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

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[BKCModel class]]) {
        return false;
    }
    BKCModel *model = object;
    if ([self Id] == [model Id] &&
        [self is_income] == [model is_income] &&
        [self is_system] == [model is_system] &&
        [self.name isEqualToString:model.name] &&
        [self.icon_n isEqualToString:model.icon_n] &&
        [self.icon_l isEqualToString:model.icon_l] &&
        [self.icon_s isEqualToString:model.icon_s]) {
        return true;
    }
    return false;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    BKCModel *model = [[[self class] allocWithZone:zone] init];
    model.Id = self.Id;
    model.name = self.name;
    model.icon_n = self.icon_n;
    model.icon_l = self.icon_l;
    model.icon_s = self.icon_s;
    model.is_income = self.is_income;
    model.is_system = self.is_system;
    return model;
}


@end



@implementation BKCIncomeModel

+ (void)load {
    [BKCIncomeModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list": @"BKCModel"};
    }];
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
