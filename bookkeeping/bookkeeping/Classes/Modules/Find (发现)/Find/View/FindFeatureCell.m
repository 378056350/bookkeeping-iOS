//
//  FindFeatureCell.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/3.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "FindFeatureCell.h"

#pragma mark - 声明
@interface FindFeatureCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end


#pragma mark - 实现
@implementation FindFeatureCell

- (void)initUI {
    [self.name setFont:[UIFont systemFontOfSize:AdjustFont(10)]];
    [self.name setTextColor:kColor_Text_Black];
    [self.icon setContentMode:UIViewContentModeScaleAspectFit];
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"module%ld", indexPath.row + 1]];
    if (indexPath.row == 0) {
        _name.text = @"朋友圈";
    }
    else if (indexPath.row == 1) {
        _name.text = @"Async朋友圈";
    }
}


@end
