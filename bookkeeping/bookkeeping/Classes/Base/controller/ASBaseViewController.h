//
//  ASBaseViewController.h
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/7.
//  Copyright © 2019 kk. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASBaseViewController : ASViewController

// 标题
@property (nonatomic, strong) NSString *navTitle;
// 按钮
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

NS_ASSUME_NONNULL_END
