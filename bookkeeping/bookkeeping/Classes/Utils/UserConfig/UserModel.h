//
//  UserModel.h
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/9.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : BaseModel

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *img1;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *open_id;
@property (nonatomic, assign) NSInteger operating_id;
@property (nonatomic, assign) BOOL sex;


@end

NS_ASSUME_NONNULL_END
