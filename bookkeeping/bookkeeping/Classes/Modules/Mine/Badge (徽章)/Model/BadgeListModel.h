/**
 * 徽章model
 * @author 郑业强 2018-12-21 创建文件
 */

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN


// 徽章
@interface BadgeModel : BaseModel

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger section_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *icon_n;
@property (nonatomic, strong) NSString *icon_s;
@property (nonatomic, strong) NSString *icon_big_n;
@property (nonatomic, strong) NSString *icon_big_s;
@property (nonatomic, assign) BOOL has_own;

@end


// 徽章列表
@interface BadgeListModel : BaseModel

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<BadgeModel *> *list;

@end

NS_ASSUME_NONNULL_END
