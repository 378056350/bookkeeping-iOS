/**
 * cell
 * @author 郑业强 2018-12-22 创建文件
 */

#import "InfoTableCell.h"


#pragma mark - 声明
@interface InfoTableCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIImageView *nextIcn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextConstraintW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintW;

@end


#pragma mark - 实现
@implementation InfoTableCell


- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.detailLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.detailLab setTextColor:kColor_Text_Gary];
    [self.icon.layer setCornerRadius:countcoordinatesX(30) / 2];
    [self.icon.layer setMasksToBounds:true];
    
    
    [self.iconConstraintW setConstant:countcoordinatesX(30)];
    
    [self setSelectedBackgroundView:[[UIView alloc] initWithFrame:self.frame]];
    [self.selectedBackgroundView setBackgroundColor:kColor_BG];
}

#pragma mark - set
- (void)setStatus:(InfoTableCellStatus)status {
    _status = status;
    if (status == InfoTableCellStatusIcon) {
        self.detailLab.hidden = YES;
        self.nextIcn.hidden = YES;
        self.icon.hidden = NO;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else if (status == InfoTableCellStatusName) {
        self.detailLab.hidden = NO;
        self.nextIcn.hidden = YES;
        self.icon.hidden = YES;
        self.nextConstraintW.constant = 0;
        self.nextConstraintL.constant = 0;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (status == InfoTableCellStatusNext) {
        self.detailLab.hidden = NO;
        self.nextIcn.hidden = NO;
        self.icon.hidden = YES;
        self.nextConstraintW.constant = countcoordinatesX(10);
        self.nextConstraintL.constant = countcoordinatesX(5);
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    self.status = ({
        InfoTableCellStatus status;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                status = InfoTableCellStatusIcon;
            } else if (indexPath.row == 1 || indexPath.row == 5) {
                status = InfoTableCellStatusName;
            } else {
                status = InfoTableCellStatusNext;
            }
        } else {
            status = InfoTableCellStatusNext;
        }
        status;
    });
    
    if (indexPath.row == 4) {
        self.detailLab.textColor = kColor_Red_Color;
    } else {
        self.detailLab.textColor = kColor_Text_Gary;
    }
    
    // name
    NSArray *arr= @[
                    @[@"头像", @"ID", @"昵称", @"性别", @"手机号", @"QQ"],
                    @[@"修改密码"]
                    ];
    [self setName:arr[indexPath.section][indexPath.row]];
}
- (void)setModel:(UserModel *)model {
    _model = model;
    if (_indexPath.section == 0) {
        if (_indexPath.row == 0) {
            [self.icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.icon)]];
        } else if (_indexPath.row == 1) {
            [self setDetail:[@(model.Id) description]];
        } else if (_indexPath.row == 2) {
            [self setDetail:model.nickname];
        } else if (_indexPath.row == 3) {
            [self setDetail:model.sex == true ? @"男" : @"女"];
        } else if (_indexPath.row == 4) {
            if (model.account) {
                [self setDetail:model.account];
                [self setStatus:InfoTableCellStatusName];
                [self.detailLab setTextColor:kColor_Text_Gary];
            } else {
                [self setDetail:@"未绑定"];
                [self setStatus:InfoTableCellStatusNext];
                [self.detailLab setTextColor:kColor_Red_Color];
            }
        } else if (_indexPath.row == 5) {
            if (model.openid) {
                [self setDetail:model.openid];
                [self setStatus:InfoTableCellStatusName];
                [self.detailLab setTextColor:kColor_Text_Gary];
            }
            else {
                [self setDetail:@"未绑定"];
                [self setStatus:InfoTableCellStatusNext];
                [self.detailLab setTextColor:kColor_Red_Color];
            }
        }
    }
}

- (void)setName:(NSString *)name {
    _name = name;
    _nameLab.text = name;
}
- (void)setDetail:(NSString *)detail {
    _detail = detail;
    _detailLab.text = detail;
}


@end
