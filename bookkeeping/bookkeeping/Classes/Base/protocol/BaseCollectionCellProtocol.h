//
//  BaseCollectionCellProtocol.h
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/14.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseCollectionCellProtocol <NSObject>
@optional
// Cell尺寸
+ (NSValue *)createCellSize;
// Cell尺寸
+ (NSValue *)createCellSizeWithIndex:(NSIndexPath *)indexPath;

@required
// 行间距
+ (NSValue *)createMinimumLineSpacing;
// Item间距
+ (NSValue *)createMinimumInteritemSpacing;
// 组间距
+ (NSValue *)createMinimumSectionSpacing;


@end

NS_ASSUME_NONNULL_END
