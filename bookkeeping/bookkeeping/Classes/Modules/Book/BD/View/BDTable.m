//
//  BDTable.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/1/6.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "BDTable.h"
#import "BDTableCell.h"

#pragma mark - 声明
@interface BDTable()<UITableViewDelegate, UITableViewDataSource>

@end


#pragma mark - 实现
@implementation BDTable


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    [self setDelegate:self];
    [self setDataSource:self];
    [self lineHide];
    [self setSeparatorInset:UIEdgeInsetsMake(0, countcoordinatesX(15), 0, 0)];
    [self setSeparatorColor:kColor_Line_Color];
}


#pragma mark - set
- (void)setModel:(BKModel *)model {
    _model = model;
    [self reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model ? 4 : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDTableCell *cell = [BDTableCell loadFirstNib:tableView];
    cell.indexPath = indexPath;
    cell.model = _model;
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}


@end
