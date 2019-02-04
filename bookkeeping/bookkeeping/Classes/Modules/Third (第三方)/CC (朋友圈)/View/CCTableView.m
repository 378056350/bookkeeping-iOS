//
//  CCTableView.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/4.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "CCTableView.h"
#import "CCInfoCell.h"
#import "CCIconCell.h"
#import "CCActionCell.h"
#import "CCReplyCell.h"
#import "CCCellConfig.h"

#pragma mark - 声明
@interface CCTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation CCTableView


#pragma mark - 初始化
+ (instancetype)initWithFrame:(CGRect)frame {
    CCTableView *table = [[CCTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [table setDelegate:table];
    [table setDataSource:table];
    [table lineAll];
    [table lineHide];
    [table setSeparatorColor:[UIColor clearColor]];
    [table setShowsVerticalScrollIndicator:false];
    return table;
}


#pragma mark - 事件
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    [self handleEventWithName:eventName data:data];
}
- (void)handleEventWithName:(NSString *)eventName data:(id)data {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    [super routerEventWithName:eventName data:data];
}
- (void)showClick:(CCInfoCell *)cell {
//    NSIndexPath *indexPath = cell.indexPath;
    cell.model.isShow = false;
    
    [self beginUpdates];
    [self endUpdates];
}


#pragma mark - set
- (void)setModels:(NSArray<CCModel *> *)models {
    _models = models;
    [self reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CCInfoCell *cell = [CCInfoCell loadCode:tableView];
        [cell setModel:self.models[indexPath.section]];
        [cell setIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 1) {
        CCIconCell *cell = [CCIconCell loadCode:tableView];
        [cell setModel:self.models[indexPath.section]];
        [cell setIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 2) {
        CCActionCell *cell = [CCActionCell loadCode:tableView];
        [cell setIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 3) {
        CCReplyCell *cell = [CCReplyCell loadCode:tableView];
        [cell setModel:self.models[indexPath.section]];
        [cell setIndexPath:indexPath];
        return cell;
    }
    return nil;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [CCInfoCell getCellHeight:self.models[indexPath.section]];
    } else if (indexPath.row == 1) {
        return [CCIconCell getCellHeight:self.models[indexPath.section]];
    } else if (indexPath.row == 2) {
        return [CCActionCell getCellHeight:self.models[indexPath.section]];
    } else if (indexPath.row == 3) {
        return [CCReplyCell getCellHeight:self.models[indexPath.section]];
    }
    return 0;
}


#pragma mark - get
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           CELL_SHOW_CLICK: [self createInvocationWithSelector:@selector(showClick:)]
                           };
    }
    return _eventStrategy;
}



@end
