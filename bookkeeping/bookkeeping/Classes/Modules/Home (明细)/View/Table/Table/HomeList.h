/**
 * 列表
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BaseView.h"
#import "BKModel.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - ENUM
typedef NS_ENUM(NSInteger, HomeListStatus) {
    HomeListStatusNormal, // 正常
    HomeListStatusPull,   // 下拉
    HomeListStatusUp,     // 上拉
};


#pragma mark - 声明
@interface HomeList : BaseView

@property (nonatomic, assign) HomeListStatus status;
//@property (nonatomic, strong) BKModel *model;
@property (nonatomic, strong) NSMutableArray<BKMonthModel *> *models;

@end


NS_ASSUME_NONNULL_END
