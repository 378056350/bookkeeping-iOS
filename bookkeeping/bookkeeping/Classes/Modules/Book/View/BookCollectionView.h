/**
 * 列表
 * @author 郑业强 2018-12-16 创建文件
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *selectIndex;

- (void)reloadSelectIndex;
+ (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
