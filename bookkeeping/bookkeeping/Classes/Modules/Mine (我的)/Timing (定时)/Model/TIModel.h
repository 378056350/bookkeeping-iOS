//
//  TIModel.h
//  bookkeeping
//
//  Created by zhongke on 2018/12/27.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TIModel : BaseModel

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger customer_id;

@end

NS_ASSUME_NONNULL_END
