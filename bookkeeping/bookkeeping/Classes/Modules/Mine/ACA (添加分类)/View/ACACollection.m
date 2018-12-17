/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ACACollection.h"
#import "ACACollectionCell.h"


#pragma mark - 声明
@interface ACACollection()<UICollectionViewDelegate, UICollectionViewDataSource>

@end


#pragma mark - 实现
@implementation ACACollection


- (void)initUI {
    [self registerNib:[UINib nibWithNibName:@"ACACollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ACACollectionCell"];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACACollectionCell *cell = [ACACollectionCell loadItem:collectionView index:indexPath];
    return cell;
}


@end
