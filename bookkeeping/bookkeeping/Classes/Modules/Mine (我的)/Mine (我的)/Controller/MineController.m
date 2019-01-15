/**
 * 记账
 * @author 郑业强 2018-12-16 创建文件
 */

#import "MineController.h"
#import "BadgeController.h"
#import "CAController.h"
#import "WebVC.h"
#import "TIController.h"
#import "ShareController.h"
#import "AboutController.h"
#import "InfoController.h"
#import "LoginController.h"
#import "MINE_EVENT_MANAGER.h"


#pragma mark - 声明
@interface MineController()

@property (nonatomic, strong) UserModel *model;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation MineController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:YES];
    [self mine];
    [self setupUI];
}
- (void)setupUI {
    // 登录了
    if ([UserInfo isLogin]) {
        [self getInfoRequest];
    }
    // 未登录
    else {
        
    }
}


#pragma mark - 请求
// 获取个人信息
- (void)getInfoRequest {
    UserModel *model = [UserInfo loadUserInfo];
    NSString *key = model.openid ? @"openid" : @"account";
    NSString *value = model.openid ? model.openid : model.account;
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:value, key, nil];
    @weakify(self)
    [self.afn_request setAfn_useCache:false];
    [AFNManager POST:InfoRequest params:param complete:^(APPResult *result) {
        @strongify(self)
        if (result.status == ServiceCodeSuccess) {
            [UserInfo saveUserInfo:result.data];
            [self.mine.table setModel:[UserInfo loadUserInfo]];
        }
    }];
}
// 打卡
- (void)createPunchRequest {
    // CreatePunchRequest
    @weakify(self)
    [self showProgressHUD];
    [AFNManager POST:CreatePunchRequest params:nil complete:^(APPResult *result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            UserModel *model = [UserInfo loadUserInfo];
            model.isPunch = true;
            model.punchCount = result.data;
            [UserInfo saveUserModel:model];
            [self.mine.table setModel:model];
            
            KKPopup *popup = [KKPopup initNib:@"BookPunch"];
            [popup show];
            [popup setClick:^(id data, KKPopup *popup) {
                [popup hide];
            }];
        } else {
            [self showWindowTextHUD:result.message delay:1.f];
        }
    }];
}
// 声音
- (void)soundChangeRequest:(NSNumber *)isOn {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:isOn, @"sound", nil];;
    [AFNManager POST:SoundRequest params:param complete:^(APPResult *result) {
        UserModel *model = [UserInfo loadUserInfo];
        model.sound = [isOn integerValue];
        [UserInfo saveUserModel:model];
    }];
}
// 详情
- (void)detailChangeRequest:(NSNumber *)isOn {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:isOn, @"detail", nil];;
    [AFNManager POST:DetailRequest params:param complete:^(APPResult *result) {
        UserModel *model = [UserInfo loadUserInfo];
        model.detail = [isOn integerValue];
        [UserInfo saveUserModel:model];
    }];
}


#pragma mark - set
// 数据
- (void)setModel:(UserModel *)model {
    _model = model;
    _mine.model = model;
}


#pragma mark - 事件
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    [self handleEventWithName:eventName data:data];
}
- (void)handleEventWithName:(NSString *)eventName data:(id)data {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    [super routerEventWithName:eventName data:data];
}
// Cell
- (void)mineCellClick:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 徽章
        if (indexPath.row == 0) {
            BadgeController *vc = [[BadgeController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        // 类别
        if (indexPath.row == 0) {
            CAController *vc = [[CAController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        // 定时
        else if (indexPath.row == 1) {
            TIController *vc = [[TIController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 2) {
        // 去App Store给鲨鱼记账评分
        if (indexPath.row == 0) {
            
        }
        // 意见反馈
        else if (indexPath.row == 1) {
            
        }
        // 同步数据
        else if (indexPath.row == 2 && [UserInfo isLogin]) {
            [self.view syncedDataRequest];
        }
        // 帮助
        else if ((indexPath.row == 3  && [UserInfo isLogin]) || (indexPath.row == 2  && [UserInfo isLogin])) {
            WebVC *vc = [[WebVC alloc] init];
            [vc setNavTitle:@"帮助"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        // 关于
        else if ((indexPath.row == 4  && [UserInfo isLogin]) || (indexPath.row == 3  && [UserInfo isLogin])) {
            AboutController *vc = [[AboutController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
// 头像
- (void)headerIconClick:(id)data {
    // 登录了
    if ([UserInfo isLogin] == true) {
        InfoController *vc = [[InfoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 没登录
    else {
        @weakify(self)
        LoginController *vc = [[LoginController alloc] init];
        [vc setComplete:^{
            @strongify(self)
            self.model = [UserInfo loadUserInfo];
        }];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}
// 打卡
- (void)punchClick:(id)data {
    // 登录了
    if ([UserInfo isLogin] == true) {
        UserModel *model = [UserInfo loadUserInfo];
        if (model.isPunch == false) {
            [self createPunchRequest];
        } else {
            // 分享
        }
    }
    // 没登录
    else {
        LoginController *vc = [[LoginController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}
// 连续打卡
- (void)headerPunchClick:(id)data {
    ShareController *vc = [[ShareController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
// 记账总天数
- (void)headerDayClick:(id)data {
    
}
// 记账总笔数
- (void)headerNumberClick:(id)data {
    
}
// 切换声音
- (void)soundClick:(NSNumber *)isOn {
    NSNumber *sound = [NSUserDefaults objectForKey:PIN_SETTING_SOUND];
    NSNumber *sound_synced = [NSUserDefaults objectForKey:PIN_SETTING_SOUND_SYNCED];
    sound = @(![sound boolValue]);
    [NSUserDefaults setObject:sound forKey:PIN_SETTING_SOUND];
    if (![sound isEqual:sound_synced]) {
        [NSUserDefaults setObject:sound forKey:PIN_SETTING_SOUND_SYNCED];
    }
    
}
// 切换详情
- (void)detailClick:(NSNumber *)isOn {
    NSNumber *detail = [NSUserDefaults objectForKey:PIN_SETTING_DETAIL];
    NSNumber *detail_synced = [NSUserDefaults objectForKey:PIN_SETTING_DETAIL_SYNCED];
    detail = @(![detail boolValue]);
    [NSUserDefaults setObject:detail forKey:PIN_SETTING_DETAIL];
    if (![detail isEqual:detail_synced]) {
        [NSUserDefaults setObject:detail forKey:PIN_SETTING_DETAIL_SYNCED];
    }
}


#pragma mark - get
- (MineView *)mine {
    if (!_mine) {
        _mine = [MineView loadCode:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabbarHeight)];
        [self.view addSubview:_mine];
    }
    return _mine;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           MINE_CELL_CLICK: [self createInvocationWithSelector:@selector(mineCellClick:)],
                           MINE_HEADER_ICON_CLICK: [self createInvocationWithSelector:@selector(headerIconClick:)],
                           MINE_PUNCH_CLICK: [self createInvocationWithSelector:@selector(punchClick:)],
                           MINE_HEADER_PUNCH_CLICK: [self createInvocationWithSelector:@selector(headerPunchClick:)],
                           MINE_HEADER_DAY_CLICK: [self createInvocationWithSelector:@selector(headerDayClick:)],
                           MINE_HEADER_NUMBER_CLICK: [self createInvocationWithSelector:@selector(headerNumberClick:)],
                           MINE_SOUND_CLICK: [self createInvocationWithSelector:@selector(soundClick:)],
                           MINE_DETAIL_CLICK: [self createInvocationWithSelector:@selector(detailClick:)]
                           };
    }
    return _eventStrategy;
}


#pragma mark - 系统
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setModel:[UserInfo loadUserInfo]];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupUI];
}


@end
