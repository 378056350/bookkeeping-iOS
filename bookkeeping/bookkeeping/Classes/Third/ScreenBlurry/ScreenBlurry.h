//
//  ScreenBlurry.h
//  ScreenBlurryDemo
//
//  Created by 邵仕宇 on 2017/3/10.
//  Copyright © 2017年 邵仕宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenBlurry : NSObject

+ (void)addBlurryScreenImage;       //从后台进入前台添加模糊效果

+ (void)removeBlurryScreenImage;    //进入前台后去除模糊效果

@end
