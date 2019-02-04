//
//  CCReplyCell.h
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/4.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "BaseTableCell.h"
#import "CCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCReplyCell : BaseTableCell

@property (nonatomic, strong) CCModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (CGFloat)getCellHeight:(CCModel *)model;

@end

NS_ASSUME_NONNULL_END
