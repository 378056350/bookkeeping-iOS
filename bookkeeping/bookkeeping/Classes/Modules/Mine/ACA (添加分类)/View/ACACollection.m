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


+ (instancetype)initWithFrame:(CGRect)frame {
    ACACollection *collection = [[ACACollection alloc] initWithFrame:frame collectionViewLayout:({
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(SCREEN_WIDTH / 5, SCREEN_WIDTH / 5);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        flow;
    })];
    collection.delegate = collection;
    collection.dataSource = collection;
    collection.backgroundColor = kColor_BG;
    return collection;
}
- (void)initUI {
    [self registerNib:[UINib nibWithNibName:@"ACACollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ACACollectionCell"];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACACollectionCell *cell = [ACACollectionCell loadItem:collectionView index:indexPath];
    cell.backgroundColor = kColor_Text_Red;
    return cell;
}


#pragma mark - UICollectionViewDelegate



@end
