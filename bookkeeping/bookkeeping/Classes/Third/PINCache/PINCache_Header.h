/**
 * 本地数据键值对
 * @author 郑业强 2019-01-03 创建文件
 */

#ifndef PINCache_Header_h
#define PINCache_Header_h

#define PIN_FIRST_RUN               @"PIN_FIRST_RUN"                   // 第一次运行程序

#define PIN_CATE_SYS_HAS            @"PIN_CATE_SYS_HAS"                // 系统 - 添加的
#define PIN_CATE_SYS_REMOVE         @"PIN_CATE_SYS_REMOVE"             // 系统 - 删除的
#define PIN_CATE_SYS_HAS            @"PIN_CATE_SYS_HAS"                // 用户 - 添加的

#define PIN_CATE_SYS_REMOVE_NONE_SYNCED  @"PIN_CATE_SYS_REMOVE_NONE_SYNCED"      // 系统 - 删除的 - 未同步(同步后应该为空)
#define PIN_CATE_SYS_REMOVE_NONE_SYNCED  @"PIN_CATE_SYS_REMOVE_NONE_SYNCED"      // 用户 - 删除的 - 未同步(同步后应该为空)

#import "PINCacheManager.h"

#endif
