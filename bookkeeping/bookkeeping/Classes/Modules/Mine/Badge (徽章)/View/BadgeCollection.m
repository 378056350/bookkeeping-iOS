/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BadgeCollection.h"
#import "BadgeCollectionCell.h"
#import "BadgeReusableHeader.h"
#import "BadgeReusableFooter.h"
#import "KKBadge.h"
#import "ShareController.h"
#import "JHCollectionViewFlowLayout.h"


#pragma mark - 声明
@interface BadgeCollection()<UICollectionViewDataSource, UICollectionViewDelegate, JHCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;

@end


#pragma mark - 实现
@implementation BadgeCollection


- (void)initUI {
    [self collection];
}


#pragma mark - set
- (void)setModels:(NSArray<BadgeListModel *> *)models {
    _models = models;
    [self.collection reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.models.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models[section].list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BadgeCollectionCell *cell = [BadgeCollectionCell loadItem:collectionView index:indexPath];
    cell.model = self.models[indexPath.section].list[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    BadgeModel *model = _models[indexPath.section].list[indexPath.row];
    KKPopup *popup = [KKPopup initNib:@"KKBadge"];
    KKBadge *badge = (KKBadge *)popup.contentv;
    [badge setBackgroundColor:[UIColor clearColor]];
    [badge setModel:model];
    [popup show];
    [popup setClick:^(NSNumber *number, KKPopup *popup) {
        @strongify(self)
        [popup hide:^{
            if ([number integerValue] == 1) {
                ShareController *vc = [[ShareController alloc] init];
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
                [self.viewController presentViewController:nav animated:YES completion:nil];
            }
        }];
    }];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        BadgeReusableHeader *header = [BadgeReusableHeader initWithCollection:collectionView kind:kind indexPath:indexPath];
        header.model = self.models[indexPath.section];
        return header;
    } else if (kind == UICollectionElementKindSectionFooter) {
        BadgeReusableFooter *footer = [BadgeReusableFooter initWithCollection:collectionView kind:kind indexPath:indexPath];
        return footer;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, countcoordinatesX(40));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, countcoordinatesX(10));
}


#pragma mark - JHCollectionViewDelegateFlowLayout
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section {
    return kColor_White;
}


#pragma mark - get
- (UICollectionView *)collection {
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:({
            JHCollectionViewFlowLayout *flow = [[JHCollectionViewFlowLayout alloc] init];
            flow.scrollDirection = UICollectionViewScrollDirectionVertical;
            flow.itemSize = CGSizeMake(SCREEN_WIDTH / 3, countcoordinatesX(135));
            flow.minimumLineSpacing = 0;
            flow.minimumInteritemSpacing = 0;
            flow;
        })];
        [_collection setShowsVerticalScrollIndicator:NO];
        [_collection setShowsHorizontalScrollIndicator:NO];
        [_collection setBackgroundColor:kColor_BG];
        [_collection setDelegate:self];
        [_collection setDataSource:self];
        [_collection registerNib:[UINib nibWithNibName:@"BadgeReusableHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BadgeReusableHeader"];
        [_collection registerNib:[UINib nibWithNibName:@"BadgeCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BadgeCollectionCell"];
        [_collection registerClass:[BadgeReusableFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"BadgeReusableFooter"];
        [self addSubview:_collection];
    }
    return _collection;
}



@end
