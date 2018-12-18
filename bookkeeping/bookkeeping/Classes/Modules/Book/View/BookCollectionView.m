/**
 * 列表
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BookCollectionView.h"
#import "BookCollectionCell.h"
#import "BOOK_EVENT_MANAGER.h"


#pragma mark - 声明
@interface BookCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@end


#pragma mark - 实现
@implementation BookCollectionView


#pragma mark - 初始化
+ (instancetype)initWithFrame:(CGRect)frame {
    BookCollectionView *collection = [[BookCollectionView alloc] initWithFrame:frame collectionViewLayout:({
        CGFloat padding = countcoordinatesX(10);
        CGFloat count = 4;
        CGFloat width = (SCREEN_WIDTH - padding * 2) / count;
        CGFloat height = width;
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(width, height);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        flow;
    })];
    [collection setShowsVerticalScrollIndicator:NO];
    [collection setShowsHorizontalScrollIndicator:NO];
    [collection setBackgroundColor:kColor_BG];
    [collection setContentInset:UIEdgeInsetsMake(countcoordinatesX(10), countcoordinatesX(10), SafeAreaBottomHeight + countcoordinatesX(10), countcoordinatesX(10))];
    [collection setDelegate:collection];
    [collection setDataSource:collection];
    [collection registerNib:[UINib nibWithNibName:@"BookCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BookCollectionCell"];
    return collection;
}


#pragma mark - 操作
// 刷新index
- (void)reloadSelectIndex {
    _selectIndex = nil;
    [self reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 90;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionCell *cell = [BookCollectionCell loadItem:collectionView index:indexPath];
    cell.choose = _selectIndex && (_selectIndex.row == indexPath.row) && (_selectIndex.section == indexPath.section);
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectIndex = indexPath;
    [self reloadData];
    [self routerEventWithName:BOOK_CLICK_ITEM data:indexPath];
}



@end
