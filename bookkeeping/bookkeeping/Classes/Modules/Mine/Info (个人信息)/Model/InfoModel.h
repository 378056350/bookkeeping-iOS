//
//  InfoModel.h
//  bookkeeping
//
//  Created by 郑业强 on 2018/12/24.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoModel : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *qq_openid;
@property (nonatomic, strong) NSString *token;

@end

NS_ASSUME_NONNULL_END
