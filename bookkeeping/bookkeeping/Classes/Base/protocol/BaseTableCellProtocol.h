//
//  BaseTableCellProtocol.h
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/16.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseTableCellProtocol <NSObject>
@optional
+ (NSNumber *)createCellHeight;
+ (NSNumber *)createCellHeightWithIndex:(NSIndexPath *)indexPath;
+ (NSNumber *)createCellHeightWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
