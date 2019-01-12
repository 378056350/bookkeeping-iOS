/**
 * 滚轴
 * @author 郑业强 2019-01-09 创建文件
 */

#import "StartScroll.h"
#import "StartScrollCell.h"


#pragma mark - 声明
@interface StartScroll()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> 

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UICollectionView *collection;

@end


#pragma mark - 实现
@implementation StartScroll


- (void)initUI {
    [self leftBtn];
    [self rightBtn];
    [self collection];
    _currentPage = 0;
}


#pragma mark - 点击
- (void)leftBtnClick {
    _currentPage -= 1;
    _currentPage = _currentPage < 0 ? 0 : _currentPage;
    [self.collection setContentOffset:CGPointMake(self.collection.width * _currentPage, 0) animated:true];
}
- (void)rightBtnClick {
    NSInteger maxPage = self.models.count % 5 == 0 ? self.models.count / 5 : self.models.count / 5 + 1;
    _currentPage += 1;
    _currentPage = _currentPage >= maxPage ? maxPage - 1 : _currentPage;
    [self.collection setContentOffset:CGPointMake(self.collection.width * _currentPage, 0) animated:true];
}


#pragma mark - set
- (void)setSegIndex:(NSInteger)segIndex {
    _segIndex = segIndex;
    _currentPage = 0;
    [self.models removeAllObjects];
    if (segIndex == 0) {
        [_models addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_SYS_HAS_INCOME]];
        [_models addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_INCOME]];
    } else {
        [_models addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_SYS_HAS_PAY]];
        [_models addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_PAY]];
    }
    [self.collection setContentOffset:CGPointZero animated:false];
    [self.collection reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StartScrollCell *cell = [StartScrollCell loadItem:collectionView index:indexPath];
    cell.model = self.models[indexPath.row];
    cell.choose = _currentPage == indexPath.row;
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentPage = indexPath.row;
    [self.collection reloadData];
}


#pragma mark - get
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateNormal];
        [_leftBtn setFrame:CGRectMake(0, 0, countcoordinatesX(30), self.height)];
        [_leftBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"nav_next_n"] forState:UIControlStateNormal];
        [_rightBtn setFrame:CGRectMake(self.width - countcoordinatesX(30), 0, countcoordinatesX(30), self.height)];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}
- (UICollectionView *)collection {
    if (!_collection) {
        CGRect frame = CGRectMake(self.leftBtn.right, 0, self.width - self.leftBtn.width - self.rightBtn.width, self.height);
        _collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:({
            UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
            flow.itemSize = CGSizeMake(frame.size.width / 5, self.height);
            flow.minimumInteritemSpacing = 0;
            flow.minimumLineSpacing = 0;
            flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            flow;
        })];
        [_collection setShowsHorizontalScrollIndicator:false];
        [_collection setBackgroundColor:[UIColor clearColor]];
        [_collection setDelegate:self];
        [_collection setDataSource:self];
        [_collection registerNib:[UINib nibWithNibName:@"StartScrollCell" bundle:nil] forCellWithReuseIdentifier:@"StartScrollCell"];
        [self addSubview:_collection];
    }
    return _collection;
}
- (NSMutableArray<BKCModel *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
        [_models addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_SYS_HAS_INCOME]];
        [_models addObjectsFromArray:[NSUserDefaults objectForKey:PIN_CATE_CUS_HAS_INCOME]];
    }
    return _models;
}


@end
