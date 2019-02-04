//
//  CCTableView.h
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/4.
//  Copyright © 2019年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCTableView : UITableView

@property (nonatomic, strong) NSArray<CCModel *> *models;

+ (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
