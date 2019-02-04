//
//  CCModel.h
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/4.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCModel : BaseModel

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *likes;

@property (nonatomic, assign) BOOL isShow;

@end

NS_ASSUME_NONNULL_END
