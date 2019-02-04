#ifndef CCCellConfig_h
#define CCCellConfig_h

#define CELL_OUT_PADDING_W countcoordinatesX(15)    // 外间距
#define CELL_OUT_PADDING_H countcoordinatesX(15)    // 外间距
#define CELL_IN_PADDING_W  countcoordinatesX(10)    // 内间距
#define CELL_IN_PADDING_H  countcoordinatesX(10)    // 内间距
#define CELL_ICON_W countcoordinatesX(40)           // 图片宽
#define CELL_ICON_H CELL_ICON_W                     // 图片高
#define CELL_NAME_L CELL_OUT_PADDING_W + CELL_ICON_W + CELL_IN_PADDING_W                    // 姓名Left
#define CELL_NAME_W SCREEN_WIDTH - CELL_OUT_PADDING_W * 2 - CELL_ICON_W - CELL_IN_PADDING_W // 姓名宽
#define CELL_ACTION_H countcoordinatesX(30)                                                 // 操作高
#define CELL_REPLY_H countcoordinatesX(200)                                                 // 回复高

#define CELL_IMAGE_W (SCREEN_WIDTH - CELL_OUT_PADDING_W - CELL_ICON_W - CELL_IN_PADDING_W - CELL_ICON_W - CELL_IN_PADDING_W * 2) / 3  // 图片宽
#define CELL_IMAGE_H CELL_IMAGE_W

#define CELL_NAME_FONT [UIFont fontWithName:@"HelveticaNeue" size:AdjustFont(14)]           // 姓名
#define CELL_TEXT_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:AdjustFont(11)]     // 内容
#define CELL_TIME_FONT [UIFont fontWithName:@"HelveticaNeue" size:AdjustFont(10)]           // 时间

#define CELL_FONT(A, W, F) [A sizeWithMaxSize:CGSizeMake(W, MAXFLOAT) font:F].height    // 高度



#define CELL_SHOW_CLICK     @"CELL_SHOW_CLICK"  // 点击显示


#endif
