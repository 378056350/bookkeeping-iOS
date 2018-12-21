/**
 * 列表
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BookCollectionView.h"
#import "BookCollectionCell.h"
#import "BookRefreshHeader.h"
#import "BOOK_EVENT_MANAGER.h"


#define PADDING countcoordinatesX(10)               // 间距
#define ROW 4                                       // 每行几个
#define CELL_W (SCREEN_WIDTH - PADDING * 2) / ROW   // cell宽度
#define CELL_H CELL_W                               // cell高度


#pragma mark - 声明
@interface BookCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) BookRefreshHeader *mHeader;

@end


#pragma mark - 实现
@implementation BookCollectionView


#pragma mark - 初始化
+ (instancetype)initWithFrame:(CGRect)frame {
    BookCollectionView *collection = [[BookCollectionView alloc] initWithFrame:frame collectionViewLayout:({
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(CELL_W, CELL_H);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        flow;
    })];
    [collection setShowsVerticalScrollIndicator:NO];
    [collection setShowsHorizontalScrollIndicator:NO];
    [collection setBackgroundColor:kColor_BG];
    [collection setDelegate:collection];
    [collection setDataSource:collection];
    [collection registerNib:[UINib nibWithNibName:@"BookCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BookCollectionCell"];
    [collection setMj_header:[collection mHeader]];
    return collection;
}


#pragma mark - set
- (void)setModel:(BookListModel *)model {
    _model = model;
    [self reloadData];
}


#pragma mark - 操作
// 刷新index
- (void)reloadSelectIndex {
    _selectIndex = nil;
    [self reloadData];
}
// 滚动scroll
- (void)scrollToIndex:(NSIndexPath *)indexPath {
    NSInteger col = indexPath.row / ROW + 1;
    CGFloat bottomOffsetY = col * CELL_H - (self.height);
    CGFloat topOffsetY = (col - 1) * CELL_H;
    
    if (self.contentOffset.y > topOffsetY || self.contentOffset.y < bottomOffsetY) {
        if (ABS(self.contentOffset.y - topOffsetY) < ABS(self.contentOffset.y - bottomOffsetY)) {
            [self setContentOffset:CGPointMake(-self.contentInset.left, topOffsetY) animated:YES];
        } else {
            [self setContentOffset:CGPointMake(-self.contentInset.left, bottomOffsetY) animated:YES];
        }
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionCell *cell = [BookCollectionCell loadItem:collectionView index:indexPath];
    cell.model = self.model.list[indexPath.row];
    cell.choose = [_selectIndex isEqual:indexPath];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectIndex = indexPath;
    [self reloadData];
    [self routerEventWithName:BOOK_CLICK_ITEM data:indexPath];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(countcoordinatesX(10), countcoordinatesX(10), countcoordinatesX(10), countcoordinatesX(10));
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < -54) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - get
- (BookRefreshHeader *)mHeader {
    if (!_mHeader) {
        _mHeader = [BookRefreshHeader headerWithRefreshingBlock:^{
            [self.mj_header endRefreshing];
        }];
    }
    return _mHeader;
}


@end
