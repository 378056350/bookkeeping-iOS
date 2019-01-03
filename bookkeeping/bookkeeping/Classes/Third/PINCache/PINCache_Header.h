/**
 * 本地数据键值对
 * @author 郑业强 2019-01-03 创建文件
 */

#ifndef PINCache_Header_h
#define PINCache_Header_h

#define PIN_FIRST_RUN               @"PIN_FIRST_RUN"                   // 第一次运行程序


#define PIN_CATE_SYS_HAS_PAY     @"PIN_CATE_SYS_HAS_PAY"                // 系统 - 添加的 - 支出
#define PIN_CATE_SYS_REMOVE_PAY  @"PIN_CATE_SYS_REMOVE_PAY"             // 系统 - 删除的 - 支出
#define PIN_CATE_CUS_HAS_PAY     @"PIN_CATE_CUS_HAS_PAY"                // 用户 - 添加的 - 支出

#define PIN_CATE_SYS_Has_PAY_SYNCED       @"PIN_CATE_SYS_Has_PAY_SYNCED"       // 系统 - 添加的 - 支出 - 未同步(同步后应该为空)
#define PIN_CATE_SYS_REMOVE_PAY_SYNCED    @"PIN_CATE_SYS_REMOVE_PAY_SYNCED"    // 系统 - 删除的 - 支出 - 未同步(同步后应该为空)
#define PIN_CATE_CUS_HAS_PAY_SYNCED       @"PIN_CATE_CUS_HAS_PAY_SYNCED"       // 用户 - 添加的 - 支出 - 未同步(同步后应该为空)
#define PIN_CATE_CUS_REMOVE_PAY_SYNCED    @"PIN_CATE_CUS_REMOVE_PAY_SYNCED"    // 用户 - 删除的 - 支出 - 未同步(同步后应该为空)



#import "PINCacheManager.h"

#endif
