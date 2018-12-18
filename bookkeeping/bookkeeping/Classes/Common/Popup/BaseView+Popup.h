//
//  BaseView+Popup.h
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/21.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseView.h"
#import "KKPopup.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseView (Popup)

@property (nonatomic, weak) KKPopup *popup;

@end

NS_ASSUME_NONNULL_END
