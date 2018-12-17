/**
 * 图表
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ChartSubDate.h"
#import "ChartSubDateCell.h"

#pragma mark - 声明
@interface ChartSubDate()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) NSIndexPath *selectIndex;

@end


#pragma mark - 实现
@implementation ChartSubDate


- (void)initUI {
    _selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    [self collection];
    [self line];
    [self borderForColor:kColor_Line_Color borderWidth:1.f borderType:UIBorderSideTypeBottom];
}


#pragma mark - get
- (UICollectionView *)collection {
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) collectionViewLayout:({
            UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
            flow.itemSize = CGSizeMake(80, self.height);
            flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            flow;
        })];
        [_collection setShowsHorizontalScrollIndicator:NO];
        [_collection setBackgroundColor:kColor_BG];
        [_collection setDelegate:self];
        [_collection setDataSource:self];
        [_collection registerNib:[UINib nibWithNibName:@"ChartSubDateCell" bundle:nil] forCellWithReuseIdentifier:@"ChartSubDateCell"];
        [self addSubview:_collection];
    }
    return _collection;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:({
            CGFloat width = 80;
            CGFloat height = 2;
            CGFloat left = 0;
            CGFloat top = self.height - height;
            CGRectMake(left, top, width, height);
        })];
        _line.backgroundColor = kColor_Text_Black;
        [self.collection addSubview:_line];
    }
    return _line;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChartSubDateCell *cell = [ChartSubDateCell loadItem:collectionView index:indexPath];
    cell.choose = [_selectIndex isEqual:indexPath];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 移动
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [collectionView reloadItemsAtIndexPaths:({
        NSIndexPath *lastIndex = _selectIndex;
        _selectIndex = indexPath;
        NSMutableArray *arr = [NSMutableArray array];
        if (lastIndex) {
            [arr addObject:lastIndex];
        }
        [arr addObject:_selectIndex];
        arr;
    })];
    
    
    // 刷新
    ChartSubDateCell *cell = (ChartSubDateCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:.3f animations:^{
        _line.width = 20;
        _line.centerX = cell.centerX;
    }];
}



@end
