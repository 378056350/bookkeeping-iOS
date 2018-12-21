/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ACACollection.h"
#import "ACACollectionCell.h"
#import "ACAReusableHeader.h"
#import "ACA_EVENT_MANAGER.h"


#pragma mark - 声明
@interface ACACollection()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSIndexPath *indexPath;

@end


#pragma mark - 实现
@implementation ACACollection


+ (instancetype)initWithFrame:(CGRect)frame {
    ACACollection *collection = [[ACACollection alloc] initWithFrame:frame collectionViewLayout:({
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(SCREEN_WIDTH / 5, SCREEN_WIDTH / 5);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        flow;
    })];
    [collection setDelegate:collection];
    [collection setDataSource:collection];
    [collection setBackgroundColor:kColor_BG];
    [collection registerNib:[UINib nibWithNibName:@"ACACollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ACACollectionCell"];
    [collection registerNib:[UINib nibWithNibName:@"ACAReusableHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ACAReusableHeader"];
    [collection setShowsVerticalScrollIndicator:NO];
    return collection;
}


#pragma mark - set
- (void)setModels:(NSArray<ACAListModel *> *)models {
    _models = models;
    [self setIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [self routerEventWithName:ACA_CLICK_ITEM data:models[0].list[0]];
    [self reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.models.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models[section].list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACACollectionCell *cell = [ACACollectionCell loadItem:collectionView index:indexPath];
    cell.model = self.models[indexPath.section].list[indexPath.row];
    cell.choose = [self.indexPath isEqual:indexPath];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ACAReusableHeader *header = [ACAReusableHeader initWithCollection:collectionView kind:kind indexPath:indexPath];
        header.model = self.models[indexPath.section];
        return header;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, countcoordinatesX(40));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self setIndexPath:indexPath];
    [self reloadData];
    [self routerEventWithName:ACA_CLICK_ITEM data:self.models[indexPath.section].list[indexPath.row]];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.viewController.view endEditing:YES];
}


@end
