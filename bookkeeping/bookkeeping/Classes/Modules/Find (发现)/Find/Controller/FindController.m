/**
 * 记账
 * @author 郑业强 2018-12-16 创建文件
 */

#import "FindController.h"
#import "FindFeatureCell.h"
#import "BillController.h"
#import "FindBookCell.h"
#import "CCController.h"
#import "ACController.h"

#pragma mark - 声明
@interface FindController()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;

@end


#pragma mark - 实现
@implementation FindController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self collection];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 1 : 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FindBookCell *cell = [FindBookCell loadItem:collectionView index:indexPath];
        return cell;
    } else {
        FindFeatureCell *cell = [FindFeatureCell loadItem:collectionView index:indexPath];
        cell.indexPath = indexPath;
        return cell;
    }
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
    if (indexPath.section == 0) {
        BillController *vc = [[BillController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CCController *vc = [[CCController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        } else if (indexPath.row == 1) {
            ACController *vc = [[ACController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, countcoordinatesX(90));
    } else {
        return CGSizeMake(SCREEN_WIDTH / 5, SCREEN_WIDTH / 5);
    }
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, countcoordinatesX(10), 0);
    }
    return UIEdgeInsetsZero;
}


#pragma mark - get
- (UICollectionView *)collection {
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - TabbarHeight) collectionViewLayout:({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            layout;
        })];
        [_collection setBackgroundColor:kColor_BG];
        [_collection setDelegate:self];
        [_collection setDataSource:self];
        [_collection registerNib:[UINib nibWithNibName:@"FindBookCell" bundle:nil] forCellWithReuseIdentifier:@"FindBookCell"];
        [_collection registerNib:[UINib nibWithNibName:@"FindFeatureCell" bundle:nil] forCellWithReuseIdentifier:@"FindFeatureCell"];
        [self.view addSubview:_collection];
    }
    return _collection;
}


#pragma mark - 系统
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collection reloadData];
}



@end
