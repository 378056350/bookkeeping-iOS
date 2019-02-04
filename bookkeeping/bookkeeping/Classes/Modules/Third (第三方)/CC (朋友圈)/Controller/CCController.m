//
//  CCController.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/4.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "CCController.h"
#import "CCTableView.h"
#import "CCModel.h"

#pragma mark - 声明
@interface CCController()

@property (nonatomic, strong) CCTableView *table;

@end


#pragma mark - 实现
@implementation CCController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"朋友圈"];
    [self table];
    
    CCModel *model1 = [[CCModel alloc] init];
    model1.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549278760004&di=5b1b62b3d320bbe26d0ec75e9a7abe20&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F04c9ea0873ce56386c00fa96b9707bdcb33621ac5ee4-Oj3qYE_fw658";
    model1.name = @"哈哈哈";
//    model1.text = @"阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬阿克苏打瞌睡的哈萨克就打哈是可敬AA";
    model1.text = @"阿克苏打瞌睡的哈AA";
    model1.isShow = true;
    model1.images = @[
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549284976445&di=546ce3d48645ec206e0562b7323c7c1e&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201303%2F15%2F20130315223944_EvRW3.thumb.700_0.jpeg"
                      ];
    model1.likes = @[@"123"];
    
    NSMutableArray *arrm = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        [arrm addObject:model1];
    }
    
    [self.table setModels:arrm];
}


#pragma mark - get
- (CCTableView *)table {
    if (!_table) {
        _table = [CCTableView initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight)];
        [self.view addSubview:_table];
    }
    return _table;
}


@end
