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
@property (nonatomic, strong) ChartSubModel *selectModel;

@end


#pragma mark - 实现
@implementation ChartDate


- (void)initUI {
    [self setBackgroundColor:kColor_White];
    [self collection];
    [self line];
    [self borderForColor:kColor_Line_Color borderWidth:1.f borderType:UIBorderSideTypeBottom];
}


#pragma mark - set
- (void)setModel:(BKModel *)model {
    _model = model;
    
    // 周
    if (_segmentIndex == 0) {
        NSDate *minDate = _timeModel.min_date;
        NSDate *maxDate = _timeModel.max_date;
        
        NSMutableArray<ChartSubModel *> *submodels = [[NSMutableArray alloc] init];
        NSInteger weeks = [NSDate compareWeek:minDate withDate:maxDate];
        for (NSInteger i=0; i<weeks; i++) {
            NSDate *newDate = [minDate offsetDays:i * 7];
            ChartSubModel *submodel = [ChartSubModel init];
            [submodel setYear:[newDate year]];
            [submodel setMonth:[newDate month]];
            [submodel setDay:[newDate day]];
            [submodel setWeek:[newDate weekOfYear]];
            [submodel setSelectIndex:0];
            [submodel setWeek_day:[newDate weekday]];
            [submodels addObject:submodel];
        }
        [self setSubModels:submodels];
    }
    // 月
    else if (_segmentIndex == 1) {
        // 数据整理
        NSMutableArray<ChartSubModel *> *submodels = [[NSMutableArray alloc] init];
        for (NSInteger y=_timeModel.min_year; y<=_timeModel.max_year; y++) {
            NSInteger min_month = (y==_timeModel.min_year ? _timeModel.min_month : 1);
            NSInteger max_month = (y==_timeModel.max_year ? _timeModel.max_month : 12);
            for (NSInteger m=min_month; m<=max_month; m++) {
                ChartSubModel *submodel = [ChartSubModel init];
                [submodel setYear:y];
                [submodel setMonth:m];
                [submodel setSelectIndex:1];
                [submodels addObject:submodel];
            }
        }
        [self setSubModels:submodels];
    }
    // 年
    else if (_segmentIndex == 2) {
        // 数据整理
        NSMutableArray<ChartSubModel *> *submodels = [[NSMutableArray alloc] init];
        for (NSInteger y=_timeModel.min_year; y<=_timeModel.max_year; y++) {
            ChartSubModel *submodel = [ChartSubModel init];
            [submodel setYear:y];
            [submodel setSelectIndex:2];
            [submodels addObject:submodel];
        }
        [self setSubModels:submodels];
    }
    
    
    // 第一次
    if (!_selectIndex) {
        _selectIndex = [NSIndexPath indexPathForRow:_subModels.count - 1 inSection:0];
        _selectModel = [_subModels lastObject];
        [self.collection reloadData];
        [self performSelector:@selector(collectionDidSelect:) withObject:_selectIndex afterDelay:0.0];
    }
    
}
- (void)setSegmentIndex:(NSInteger)segmentIndex {
    _segmentIndex = segmentIndex;
    _selectIndex = nil;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.subModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChartDateCell *cell = [ChartDateCell loadItem:collectionView index:indexPath];
    cell.choose = [_selectIndex isEqual:indexPath];
    cell.model = self.subModels[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self collectionDidSelect:indexPath];
    // 回调
    if (self.complete) {
        ChartSubModel *model = self.subModels[indexPath.row];
        self.complete(model);
    }
}
- (void)collectionDidSelect:(NSIndexPath *)indexPath {
    // 移动
    [self.collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    // 刷新
    [self.collection reloadItemsAtIndexPaths:({
        NSIndexPath *lastIndex = _selectIndex;
        _selectIndex = indexPath;
        NSMutableArray *arr = [NSMutableArray array];
        if (lastIndex) {
            [arr addObject:lastIndex];
        }
        [arr addObject:_selectIndex];
        arr;
    })];
    // 移动
    @weakify(self)
    ChartDateCell *cell = (ChartDateCell *)[self.collection cellForItemAtIndexPath:indexPath];
    ChartSubModel *model = self.subModels[indexPath.row];
    [UIView animateWithDuration:.3f animations:^{
        @strongify(self)
        self.line.width = [model.detail sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:LAB_FONT].width;
        self.line.centerX = cell.centerX;
    }];
}


#pragma mark - get
- (UICollectionView *)collection {
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) collectionViewLayout:({
            UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
            flow.itemSize = CGSizeMake(countcoordinatesX(70), self.height);
            flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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


@end
