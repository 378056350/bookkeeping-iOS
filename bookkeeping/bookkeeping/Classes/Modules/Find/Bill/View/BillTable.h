//
//  BillTable.h
//  bookkeeping
//
//  Created by 郑业强 on 2019/1/9.
//  Copyright © 2019年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillTable : UITableView

@property (nonatomic, assign) NSInteger income;
@property (nonatomic, assign) NSInteger pay;
@property (nonatomic, strong) NSMutableArray *models;

@end

NS_ASSUME_NONNULL_END
