//
//  StartScrollCell.h
//  BookStart
//
//  Created by zhongke on 2019/1/9.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "BaseCollectionCell.h"
#import "BKCIncomeModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface StartScrollCell : BaseCollectionCell

@property (nonatomic, strong) BKCModel *model;
@property (nonatomic, assign) BOOL choose;

@end

NS_ASSUME_NONNULL_END
