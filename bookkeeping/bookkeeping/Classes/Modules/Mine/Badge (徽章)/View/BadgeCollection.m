/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BadgeCollection.h"
#import "BadgeCollectionCell.h"
#import "BaseReusableHeader.h"


#pragma mark - 声明
@interface BadgeCollection()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;

@end


#pragma mark - 实现
@implementation BadgeCollection


- (void)initUI {
    [self collection];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BadgeCollectionCell *cell = [BadgeCollectionCell loadItem:collectionView index:indexPath];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        BaseReusableHeader *header = [BaseReusableHeader initWithCollection:collectionView kind:kind indexPath:indexPath];
        return header;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, countcoordinatesX(40));
}


#pragma mark - get
- (UICollectionView *)collection {
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:({
            UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
            flow.itemSize = CGSizeMake(SCREEN_WIDTH / 3, SCREEN_WIDTH / 3);
            flow.minimumLineSpacing = 0;
            flow.minimumInteritemSpacing = 0;
            flow;
        })];
        [_collection setBackgroundColor:kColor_BG];
        [_collection setDelegate:self];
        [_collection setDataSource:self];
        [_collection registerNib:[UINib nibWithNibName:@"BaseReusableHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseReusableHeader"];
        [_collection registerNib:[UINib nibWithNibName:@"BadgeCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BadgeCollectionCell"];
        [self addSubview:_collection];
    }
    return _collection;
}




@end
