/**
 * 图表
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ChartDate.h"
#import "ChartDateCell.h"

#pragma mark - 声明
@interface ChartDate()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UIView *line;

@end


#pragma mark - 实现
@implementation ChartDate


- (void)initUI {
    [self setBackgroundColor:kColor_White];
    [self collection];
    [self line];
    [self borderForColor:kColor_Line_Color borderWidth:1.f borderType:UIBorderSideTypeBottom];
}


#pragma mark - 操作
// 更新子控件
- (void)updateDateRange {
    // 没数据
    if (!_minModel && !_maxModel) {
        [self.selectIndexs removeAllObjects];
        for (NSInteger i=0; i<3; i++) {
            [self.selectIndexs addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
            [self.sModels replaceObjectAtIndex:i withObject:({
                [NSMutableArray arrayWithObject:({
                    NSDate *date = [NSDate date];
                    date = [date offsetDays:-[date weekday]+1];
//                    NSDate *date = [NSDate createZeroDate:[NSDate date]];
                    ChartSubModel *model = [[ChartSubModel alloc] init];
                    model.year = date.year;
                    model.month = date.month;
                    model.day = date.day;
                    model.week = [date weekOfYear];
                    model.selectIndex = i;
                    model;
                })];
            })];
        }
        [self.collection reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self collectionDidSelect:self.selectIndexs[self.segmentIndex] animation:false];
        });
    }
    // 只有最大/最小数据
    if (!_minModel || !_maxModel) {
        return;
    }
    
    
    // 更新控件
    [self.selectIndexs removeAllObjects];
    // 周
    [self.sModels replaceObjectAtIndex:0 withObject:({
        NSDate *minDate = _minModel.date;
        NSDate *maxDate = _maxModel.date;
        NSMutableArray<ChartSubModel *> *submodels = [[NSMutableArray alloc] init];
        NSInteger weeks = [NSDate compareWeek:minDate withDate:maxDate];
        for (NSInteger i=0; i<weeks; i++) {
            NSDate *newDate = [minDate offsetDays:i * 7];
            newDate = [newDate offsetDays:-[newDate weekday]+1];
            ChartSubModel *submodel = [ChartSubModel init];
            [submodel setYear:[newDate year]];
            [submodel setMonth:[newDate month]];
            [submodel setDay:[newDate day]];
            [submodel setWeek:[newDate weekOfYear]];
            [submodel setWeek_day:[newDate weekday]];
            [submodel setSelectIndex:0];
            [submodels addObject:submodel];
            
            if ([[submodel detail] isEqualToString:@"本周"] && self.selectIndexs.count == 0) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.selectIndexs addObject:indexPath];
            }
        }
        if (self.selectIndexs.count == 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:submodels.count - 1 inSection:0];
            [self.selectIndexs addObject:indexPath];
        }
        submodels;
    })];
    // 月
    [self.sModels replaceObjectAtIndex:1 withObject:({
        // 数据整理
        NSMutableArray<ChartSubModel *> *submodels = [[NSMutableArray alloc] init];
        for (NSInteger y=_minModel.date.year; y<=_maxModel.date.year; y++) {
            NSInteger min_month = (y==_minModel.date.year ? _minModel.date.month : 1);
            NSInteger max_month = (y==_maxModel.date.year ? _maxModel.date.month : 12);
            for (NSInteger m=min_month; m<=max_month; m++) {
                ChartSubModel *submodel = [ChartSubModel init];
                [submodel setYear:y];
                [submodel setMonth:m];
                [submodel setSelectIndex:1];
                [submodels addObject:submodel];
                
                NSDate *date = [NSDate date];
                if (y == date.year && m == date.month && self.selectIndexs.count == 1) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:submodels.count - 1 inSection:0];
                    [self.selectIndexs addObject:indexPath];
                }
            }
        }
        if (self.selectIndexs.count == 1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:submodels.count - 1 inSection:0];
            [self.selectIndexs addObject:indexPath];
        }
        submodels;
    })];
    // 年
    [self.sModels replaceObjectAtIndex:2 withObject:({
        // 数据整理
        NSMutableArray<ChartSubModel *> *submodels = [[NSMutableArray alloc] init];
        for (NSInteger y=_minModel.date.year; y<=_maxModel.date.year; y++) {
            ChartSubModel *submodel = [ChartSubModel init];
            [submodel setYear:y];
            [submodel setSelectIndex:2];
            [submodels addObject:submodel];
            if (y == [NSDate date].year && self.selectIndexs.count == 2) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:submodels.count - 1 inSection:0];
                [self.selectIndexs addObject:indexPath];
            }
        }
        if (self.selectIndexs.count == 2) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:submodels.count - 1 inSection:0];
            [self.selectIndexs addObject:indexPath];
        }
        submodels;
    })];
    
    
    [self.collection reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self collectionDidSelect:self.selectIndexs[self.segmentIndex] animation:false];
    });

}


#pragma mark - set
- (void)setMinModel:(BKModel *)minModel {
    _minModel = minModel;
    [self updateDateRange];
}
- (void)setMaxModel:(BKModel *)maxModel {
    _maxModel = maxModel;
    [self updateDateRange];
}
- (void)setSegmentIndex:(NSInteger)segmentIndex {
    _segmentIndex = segmentIndex;
//    _selectIndex = nil;
//    [self updateDateRange];
    
    [self.collection reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self collectionDidSelect:self.selectIndexs[self.segmentIndex] animation:false];
    });
}
- (void)setNavigationIndex:(NSInteger)navigationIndex {
    _navigationIndex = navigationIndex;
    [self updateDateRange];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sModels[self.segmentIndex].count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChartDateCell *cell = [ChartDateCell loadItem:collectionView index:indexPath];
//    cell.choose = [_selectIndex isEqual:indexPath];
    cell.choose = [self.selectIndexs[self.segmentIndex] isEqual:indexPath];
    cell.model = self.sModels[self.segmentIndex][indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectIndexs replaceObjectAtIndex:self.segmentIndex withObject:indexPath];
    [self collectionDidSelect:indexPath animation:true];
    // 回调
    if (self.complete) {
        ChartSubModel *model = self.sModels[self.segmentIndex][indexPath.row];
        self.complete(model);
    }
}
- (void)collectionDidSelect:(NSIndexPath *)indexPath animation:(BOOL)animation {
    // 移动
    [self.collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animation];
    // 刷新
    [self.collection reloadItemsAtIndexPaths:({
        NSIndexPath *selectIndex = self.selectIndexs[self.segmentIndex];
        NSIndexPath *lastIndex = selectIndex;
        selectIndex = indexPath;
        NSMutableArray *arr = [NSMutableArray array];
        if (lastIndex && ![lastIndex isEqual:selectIndex]) {
            [arr addObject:lastIndex];
        }
        [arr addObject:indexPath];
        arr;
    })];
    // 移动
    NSTimeInterval duration = animation == true ? 0.3f : 0;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        ChartSubModel *model = self.sModels[self.segmentIndex][indexPath.row];
        self.line.width = [model.detail sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:LAB_FONT].width;
        
        CGFloat left = countcoordinatesX(70) * indexPath.row;
        left += indexPath.row != 0 ? indexPath.row * countcoordinatesX(10) : 0;
        left += countcoordinatesX(70) / 2;
        self.line.centerX = left;
    } completion:nil];
}


#pragma mark - get
- (UICollectionView *)collection {
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) collectionViewLayout:({
            UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
            flow.itemSize = CGSizeMake(countcoordinatesX(70), self.height);
            flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            flow.minimumLineSpacing = countcoordinatesX(10);
            flow;
        })];
        [_collection setShowsHorizontalScrollIndicator:NO];
        [_collection setBackgroundColor:kColor_White];
        [_collection setDelegate:self];
        [_collection setDataSource:self];
        [_collection registerNib:[UINib nibWithNibName:@"ChartDateCell" bundle:nil] forCellWithReuseIdentifier:@"ChartDateCell"];
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
- (NSMutableArray<NSIndexPath *> *)selectIndexs {
    if (!_selectIndexs) {
        _selectIndexs = [NSMutableArray array];
    }
    return _selectIndexs;
}
- (NSMutableArray<NSMutableArray<ChartSubModel *> *> *)sModels {
    if (!_sModels) {
        _sModels = [NSMutableArray array];
        [_sModels addObject:[NSMutableArray array]];
        [_sModels addObject:[NSMutableArray array]];
        [_sModels addObject:[NSMutableArray array]];
    }
    return _sModels;
}


@end
