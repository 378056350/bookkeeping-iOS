//
//  ACModel.h
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/8.
//  Copyright © 2019 kk. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACLikeModel : BaseModel

@property (nonatomic, copy  ) NSString *name;

@end


@interface ACReplyModel : BaseModel

@property (nonatomic, copy  ) NSString *person1;
@property (nonatomic, copy  ) NSString *person2;
@property (nonatomic, copy  ) NSString *content;

@end


@interface ACModel : BaseModel

@property (nonatomic, copy  ) NSString *icon;
@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, copy  ) NSString *text;
@property (nonatomic, copy  ) NSString *time;
@property (nonatomic, strong) NSArray<NSString *> *images;
@property (nonatomic, strong) NSArray<ACLikeModel *> *likes;
@property (nonatomic, strong) NSArray<ACReplyModel *> *replys;

@end

NS_ASSUME_NONNULL_END
