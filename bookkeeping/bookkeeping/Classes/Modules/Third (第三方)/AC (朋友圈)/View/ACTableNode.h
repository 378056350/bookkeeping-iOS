//
//  ACTableNode.h
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/7.
//  Copyright © 2019 kk. All rights reserved.
//

#import <AsyncDisplayKit/ASTableNode.h>
#import "ACModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACTableNode : ASTableNode

@property (nonatomic, strong) NSMutableArray<ACModel *> *models;

@end

NS_ASSUME_NONNULL_END
