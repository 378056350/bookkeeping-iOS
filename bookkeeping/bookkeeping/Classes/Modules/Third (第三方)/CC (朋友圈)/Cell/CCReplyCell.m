//
//  CCReplyCell.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/4.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "CCReplyCell.h"
#import "CCCellConfig.h"

#define PADDING_W countcoordinatesX(5)
#define PADDING_H countcoordinatesX(5)

#pragma mark - 声明
@interface CCReplyCell()

@property (nonatomic, strong) UIImageView *triangle;
@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UIImageView *like;
@property (nonatomic, strong) NSMutableArray *likes;

@end


#pragma mark - 实现
@implementation CCReplyCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [self triangle];
    [self content];
    [self like];
}
+ (CGFloat)getCellHeight:(CCModel *)model {
    return CELL_REPLY_H + CELL_OUT_PADDING_H;
}


#pragma mark - set
- (void)setModel:(CCModel *)model {
    _model = model;
    for (int i=0; i<model.likes.count; i++) {
        
    }
}


#pragma mark - get
- (UIImageView *)triangle {
    if (!_triangle) {
        UIImage *image = [UIImage imageNamed:@"cc_triangle"];
        
        _triangle = [[UIImageView alloc] initWithFrame:({
            CGFloat left = CELL_NAME_L + countcoordinatesX(20);
            CGFloat width = countcoordinatesX(10);
            CGFloat height = width / image.size.width * image.size.height;
            CGRectMake(left, 0, width, height);
        })];
        [_triangle setImage:image];
        [_triangle setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:_triangle];
    }
    return _triangle;
}
- (UIView *)content {
    if (!_content) {
        _content = [[UIView alloc] initWithFrame:({
            CGFloat left = CELL_NAME_L;
            CGFloat top = _triangle.bottom;
            CGFloat width = SCREEN_WIDTH - left - CELL_OUT_PADDING_W;
            CGRectMake(CELL_NAME_L, top, width, CELL_REPLY_H - top);
        })];
        [_content setRoundedCorners:UIRectCornerAllCorners radius:countcoordinatesX(2)];
        [_content setBackgroundColor:kColor_Line_Color];
        [self.contentView addSubview:_content];
    }
    return _content;
}
- (UIImageView *)like {
    if (!_like) {
        _like = [[UIImageView alloc] initWithFrame:({
            CGFloat left = PADDING_W;
            CGFloat top = PADDING_H;
            CGRectMake(left, top, countcoordinatesX(10), countcoordinatesX(10));
        })];
        [_like setContentMode:UIViewContentModeScaleAspectFit];
        [_like setImage:[UIImage imageNamed:@"like"]];
        [_content addSubview:_like];
    }
    return _like;
}
- (NSMutableArray *)likes {
    if (!_likes) {
        _likes = [[NSMutableArray alloc] init];
    }
    return _likes;
}


@end
