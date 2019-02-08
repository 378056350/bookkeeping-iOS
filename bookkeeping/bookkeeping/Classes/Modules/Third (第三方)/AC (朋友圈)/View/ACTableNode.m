//
//  ACTableNode.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/7.
//  Copyright © 2019 kk. All rights reserved.
//

#import "ACTableNode.h"
#import "ACCellMode.h"

#pragma mark - 声明
@interface ACTableNode()<ASTableDelegate, ASTableDataSource>

@end


#pragma mark - 实现
@implementation ACTableNode


- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBackgroundColor:kColor_BG];
        [self.view setShowsVerticalScrollIndicator:false];
        [self.view lineHide];
        [self.view setSeparatorColor:kColor_BG];
    }
    return self;
}


#pragma mark - set
- (void)setModels:(NSMutableArray<ACModel *> *)models {
    _models = models;
    [self reloadData];
}


#pragma mark - ASTableDataSource
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCellNode *(^cellNodeBlock)(void) = ^ASCellNode *() {
        ACCellMode *cellNode = [[ACCellMode alloc] init];
        cellNode.model = self.models[indexPath.row];
        return cellNode;
    };
    return cellNodeBlock;
}


#pragma mark - ASTableDelegate


@end
