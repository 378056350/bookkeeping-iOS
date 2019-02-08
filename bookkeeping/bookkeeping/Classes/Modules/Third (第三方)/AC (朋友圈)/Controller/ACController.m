//
//  ACController.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/7.
//  Copyright © 2019 kk. All rights reserved.
//

#import "ACController.h"
#import "ACTableNode.h"
#import "ACModel.h"

#pragma mark - 声明
@interface ACController()

@property (nonatomic, strong) ACTableNode *table;

@end


#pragma mark - 实现
@implementation ACController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Async朋友圈"];
    [self.view setBackgroundColor:kColor_BG];
    [self table];
    
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:({
        ACModel *model = [[ACModel alloc] init];
        model.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549608872215&di=eda19038af502744778a7aa5e77501d7&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F14dd0a2dc7c0d23bd06b60af16ea4f37a291bf952e0d5-k0osDN_fw236";
        model.name = @"AAAAAA";
        model.text = @"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
        model.time = @"下午11:36";
        model.images = @[
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549608872215&di=eda19038af502744778a7aa5e77501d7&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F14dd0a2dc7c0d23bd06b60af16ea4f37a291bf952e0d5-k0osDN_fw236"
                         ];
        model.likes = @[
                        ({
                            ACLikeModel *model = [[ACLikeModel alloc] init];
                            model.name = @"哈哈哈";
                            model;
                        }),
                        ({
                            ACLikeModel *model = [[ACLikeModel alloc] init];
                            model.name = @"张三";
                            model;
                        }),
                        ];
        model.replys = @[
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.person2 = @"哈哈";
                             model.content = @"柳大华吃香蕉";
                             model;
                         }),
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.content = @"柳大华吃香蕉";
                             model;
                         })
                         ];
        model;
    })];
    [arr addObject:({
        ACModel *model = [[ACModel alloc] init];
        model.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549608872215&di=eda19038af502744778a7aa5e77501d7&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F14dd0a2dc7c0d23bd06b60af16ea4f37a291bf952e0d5-k0osDN_fw236";
        model.name = @"BBBBBBB";
        model.text = @"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";
        model.time = @"下午11:36";
        model.likes = @[
                        ({
                            ACLikeModel *model = [[ACLikeModel alloc] init];
                            model.name = @"哈哈哈";
                            model;
                        }),
                        ({
                            ACLikeModel *model = [[ACLikeModel alloc] init];
                            model.name = @"张三";
                            model;
                        }),
                        ];
        model.replys = @[
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.person2 = @"哈哈";
                             model.content = @"柳大华吃香蕉";
                             model;
                         }),
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.content = @"柳大华吃香蕉";
                             model;
                         })
                         ];
        model;
    })];
    [arr addObject:({
        ACModel *model = [[ACModel alloc] init];
        model.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549608872215&di=eda19038af502744778a7aa5e77501d7&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F14dd0a2dc7c0d23bd06b60af16ea4f37a291bf952e0d5-k0osDN_fw236";
        model.name = @"CCCCCC";
        model.time = @"下午11:99";
        model.images = @[
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549608872215&di=eda19038af502744778a7aa5e77501d7&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F14dd0a2dc7c0d23bd06b60af16ea4f37a291bf952e0d5-k0osDN_fw236"
                         ];
        model.likes = @[
                        ({
                            ACLikeModel *model = [[ACLikeModel alloc] init];
                            model.name = @"哈哈哈";
                            model;
                        }),
                        ({
                            ACLikeModel *model = [[ACLikeModel alloc] init];
                            model.name = @"张三";
                            model;
                        }),
                        ];
        model.replys = @[
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.person2 = @"哈哈";
                             model.content = @"柳大华吃香蕉";
                             model;
                         }),
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.content = @"柳大华吃香蕉";
                             model;
                         })
                         ];
        model;
    })];
    [arr addObject:({
        ACModel *model = [[ACModel alloc] init];
        model.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549608872215&di=eda19038af502744778a7aa5e77501d7&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F14dd0a2dc7c0d23bd06b60af16ea4f37a291bf952e0d5-k0osDN_fw236";
        model.name = @"DDDDDDD";
        model.time = @"昨天";
        model.likes = @[
                        ({
                            ACLikeModel *model = [[ACLikeModel alloc] init];
                            model.name = @"哈哈哈";
                            model;
                        }),
                        ({
                            ACLikeModel *model = [[ACLikeModel alloc] init];
                            model.name = @"张三";
                            model;
                        }),
                        ];
        model.replys = @[
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.person2 = @"哈哈";
                             model.content = @"柳大华吃香蕉";
                             model;
                         }),
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.content = @"柳大华吃香蕉";
                             model;
                         })
                         ];
        model;
    })];
    [arr addObject:({
        ACModel *model = [[ACModel alloc] init];
        model.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549608872215&di=eda19038af502744778a7aa5e77501d7&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F14dd0a2dc7c0d23bd06b60af16ea4f37a291bf952e0d5-k0osDN_fw236";
        model.name = @"EEEEEEE";
        model.time = @"后天";
        model.replys = @[
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.person2 = @"哈哈";
                             model.content = @"柳大华吃香蕉";
                             model;
                         }),
                         ({
                             ACReplyModel *model = [[ACReplyModel alloc] init];
                             model.person1 = @"张三";
                             model.content = @"柳大华吃香蕉";
                             model;
                         })
                         ];
        model;
    })];
    [arr addObject:({
        ACModel *model = [[ACModel alloc] init];
        model.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549608872215&di=eda19038af502744778a7aa5e77501d7&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F14dd0a2dc7c0d23bd06b60af16ea4f37a291bf952e0d5-k0osDN_fw236";
        model.name = @"FFFFFFFFFF";
        model.time = @"明天";
        model;
    })];
    [self.table setModels:arr];

}


#pragma mark - get
- (ACTableNode *)table {
    if (!_table) {
        _table = [[ACTableNode alloc] initWithStyle:UITableViewStylePlain];
        _table.frame = ({
            CGFloat top = NavigationBarHeight;
            CGFloat height = SCREEN_HEIGHT - top;
            CGRectMake(0, top, SCREEN_WIDTH, height);
        });
        [self.view addSubnode:_table];
    }
    return _table;
}

@end
