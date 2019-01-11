//
//  PINCache_Header.h
//  bookkeeping
//
//  Created by 郑业强 on 2019/1/8.
//  Copyright © 2019年 kk. All rights reserved.
//

#ifndef PINCache_Header_h
#define PINCache_Header_h



#define PIN_FIRST_RUN               @"PIN_FIRST_RUN"                   // 第一次运行程序


#pragma mark - 类别
// 支出
#define PIN_CATE_SYS_HAS_PAY              @"PIN_CATE_SYS_HAS_PAY"              // 系统 - 添加的 - 支出
#define PIN_CATE_SYS_REMOVE_PAY           @"PIN_CATE_SYS_REMOVE_PAY"           // 系统 - 删除的 - 支出
#define PIN_CATE_CUS_HAS_PAY              @"PIN_CATE_CUS_HAS_PAY"              // 用户 - 添加的 - 支出
#define PIN_CATE_SYS_Has_PAY_SYNCED       @"PIN_CATE_SYS_Has_PAY_SYNCED"       // 系统 - 添加的 - 支出 - 未同步(同步后应该为空)
#define PIN_CATE_SYS_REMOVE_PAY_SYNCED    @"PIN_CATE_SYS_REMOVE_PAY_SYNCED"    // 系统 - 删除的 - 支出 - 未同步(同步后应该为空)
#define PIN_CATE_CUS_HAS_PAY_SYNCED       @"PIN_CATE_CUS_HAS_PAY_SYNCED"       // 用户 - 添加的 - 支出 - 未同步(同步后应该为空)
#define PIN_CATE_CUS_REMOVE_PAY_SYNCED    @"PIN_CATE_CUS_REMOVE_PAY_SYNCED"    // 用户 - 删除的 - 支出 - 未同步(同步后应该为空)

// 收入
#define PIN_CATE_SYS_HAS_INCOME              @"PIN_CATE_SYS_HAS_INCOME"              // 系统 - 添加的 - 收入
#define PIN_CATE_SYS_REMOVE_INCOME           @"PIN_CATE_SYS_REMOVE_INCOME"           // 系统 - 删除的 - 收入
#define PIN_CATE_CUS_HAS_INCOME              @"PIN_CATE_CUS_HAS_INCOME"              // 用户 - 添加的 - 收入
#define PIN_CATE_SYS_Has_INCOME_SYNCED       @"PIN_CATE_SYS_Has_INCOME_SYNCED"       // 系统 - 添加的 - 收入 - 未同步(同步后应该为空)
#define PIN_CATE_SYS_REMOVE_INCOME_SYNCED    @"PIN_CATE_SYS_REMOVE_INCOME_SYNCED"    // 系统 - 删除的 - 收入 - 未同步(同步后应该为空)
#define PIN_CATE_CUS_HAS_INCOME_SYNCED       @"PIN_CATE_CUS_HAS_INCOME_SYNCED"       // 用户 - 添加的 - 收入 - 未同步(同步后应该为空)
#define PIN_CATE_CUS_REMOVE_INCOME_SYNCED    @"PIN_CATE_CUS_REMOVE_INCOME_SYNCED"    // 用户 - 删除的 - 收入 - 未同步(同步后应该为空)


#pragma mark - 添加类别
#define PIN_ACA_CATE    @"PIN_ACA_CATE"    // 添加类别


#pragma mark - 记账
#define PIN_BOOK           @"PIN_BOOK"            // 记账
#define PIN_BOOK_SYNCED    @"PIN_BOOK_SYNCED"     // 未同步


#pragma mark - 个人设置
#define PIN_SETTING_SOUND     @"PIN_SETTING_SOUND"      // 声音开关
#define PIN_SETTING_DETAIL    @"PIN_SETTING_DETAIL"     // 明细详情

#define PIN_SETTING_SOUND_SYNCED     @"PIN_SETTING_SOUND_SYNCED"      // 声音开关 - 未同步
#define PIN_SETTING_DETAIL_SYNCED    @"PIN_SETTING_DETAIL_SYNCED"     // 明细详情 - 未同步


#define PIN_TIMING           @"PIN_TIMING"           // 定时通知b
#define PIN_TIMING_HAS_SYNCED       @"PIN_TIMING_HAS_SYNCED"        // 定时添加通知 - 未同步
#define PIN_TIMING_REMOVE_SYNCED    @"PIN_TIMING_REMOVE_SYNCED"     // 定时删除通知 - 未同步





#endif
