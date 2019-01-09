/**
 * 滚轴
 * @author 郑业强 2019-01-09 创建文件
 */

#import "BaseView.h"
#import "BKCIncomeModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface StartScroll : BaseView

@property (nonatomic, assign) NSInteger segIndex;
@property (nonatomic, strong) NSMutableArray<BKCModel *> *models;
@property (nonatomic, assign) NSInteger currentPage;

@end

NS_ASSUME_NONNULL_END
