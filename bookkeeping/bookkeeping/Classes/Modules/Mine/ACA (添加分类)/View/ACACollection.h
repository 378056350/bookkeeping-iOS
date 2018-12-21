/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseCollectionView.h"
#import "ACAListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACACollection : BaseCollectionView

@property (nonatomic, strong) NSArray<ACAListModel *> *models;

+ (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
