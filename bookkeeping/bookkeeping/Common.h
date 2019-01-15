/**
 * 系统配置
 * @author 郑业强 2018-12-16 创建文件
 */

#ifndef Common_h
#define Common_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

//================================= Third ===================================//
#import <JGProgressHUD/JGProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import <JZNavigationExtension/JZNavigationExtension.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <MJRefresh/MJRefresh.h>
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <pop/POP.h>
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import <ZLPhotoBrowser/ZLPhotoActionSheet.h>
#import <ZLPhotoBrowser/ZLCustomCamera.h>
#import <BRPickerView/BRPickerView.h>


//================================= Event/Notification =================================//
#import "BOOK_EVENT.h"


//================================= Base =====================================//
#import "BaseView.h"
#import "BaseModel.h"
#import "BaseTableView.h"
#import "BaseTableCellProtocol.h"
#import "BaseCollectionCellProtocol.h"
#import "BaseViewController.h"
#import "BaseCollectionView.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseTableCell.h"


//================================= Category =================================//
#import "NSString+Extension.h"
#import "NSString+Encryption.h"
#import "NSObject+JGRuntime.h"
#import "NSAttributedString+Extension.h"
#import "NSAttributedString+Extension.h"
#import "NSDate+Extension.h"
#import "NSObject+NSCoding.h"
#import "NSUserDefaults+Extension.h"
#import "NSMutableArray+Extension.h"
#import "NSString+Calculation.h"
#import "UIFont+Extension.h"
#import "UIView+Extension.h"
#import "UIView+BlockGesture.h"
#import "UIViewController+JGProgressHUD.h"
#import "UIColor+HEX.h"
#import "UIButton+BarButtonItem.h"
#import "UIView+BorderLine.h"
#import "UIView+Visuals.h"
#import "UIImage+Extension.h"
#import "UIResponder+QFEventHandle.h"
#import "UIScrollView+Extension.h"
#import "UITableView+Extension.h"
#import "UITableViewCell+Extension.h"
#import "UIViewController+UMengExtension.h"
#import "UIView+JGProgressHUD.h"
#import "UIWindow+JGProgressHUD.h"
#import "UITableViewCell+Extension.h"
#import "UIViewController+Extension.h"
#import "ZLPhotoActionSheet+Extension.h"
#import "CALayer+Extension.h"
#import "BaseNavigationController+Extension.h"
#import "UIView+SyncedData.h"


//================================= Util =====================================//
#import "Single.h"
#import "BookPunch.h"
#import "KKPopup.h"
#import "KKEmptyPch.h"
#import "UserInfo.h"
#import "CountDown.h"
#import "PINCache_Header.h"
#import "ScreenBlurry.h"


//================================= Network ==================================//
#import "NSString+API.h"
#import "APPResult.h"
#import "AFNManager.h"
#import "APPViewRequest.h"
#import "UIViewController+APPViewRequest.h"
#import "UIView+APPViewRequest.h"


//================================= Controller ===============================//
#import "HomeController.h"
#import "ChartController.h"
#import "BKCController.h"
#import "FindController.h"
#import "MineController.h"





#endif







////    NSArray *arr = @[@"餐饮",@"零食",@"购物",@"交通",@"运动",@"汽车",@"医疗",@"宠物",@"书籍",@"学习",@"礼物",@"办公",@"维修",@"捐赠",@"彩票",@"快递",@"社交",@"美容",@"水果",@"旅行",@"娱乐",@"礼金",@"蔬菜",@"长辈",@"住房",@"孩子",@"通讯",@"服饰",@"日用",@"烟酒",@"亲友",@"数码",@"居家"];
//    NSArray *arr = @[@"工资",@"兼职",@"理财",@"礼金",@"其它"];
//    NSMutableString *strm = [[NSMutableString alloc] init];
//    for (NSInteger i=34; i<arr.count + 34; i++) {
//        [strm appendFormat:@"<dict>\n"];
//        [strm appendFormat:@"<key>id</key>\n"];
//        [strm appendFormat:@"<integer>%ld</integer>\n", i];
//        [strm appendFormat:@"<key>icon_n</key>\n"];
//        [strm appendFormat:@"<string>book/e_snack@3x.png</string>\n"];
//        [strm appendFormat:@"<key>icon_l</key>\n"];
//        [strm appendFormat:@"<string>book/e_snack_l@3x.png</string>\n"];
//        [strm appendFormat:@"<key>icon_s</key>\n"];
//        [strm appendFormat:@"<string>book/e_snack_s@3x.png</string>\n"];
//        [strm appendFormat:@"<key>is_income</key>\n"];
//        [strm appendFormat:@"<integer>1</integer>\n"];
//        [strm appendFormat:@"<key>is_system</key>\n"];
//        [strm appendFormat:@"<integer>1</integer>\n"];
//        [strm appendFormat:@"<key>name</key>\n"];
//        [strm appendFormat:@"<string>%@</string>\n", arr[i-34]];
//        [strm appendFormat:@"</dict>\n"];
//    }


//
//NSInteger Id = 20;
//NSArray *arr = @[@"饮食",@"医疗",@"学习",@"交通",@"购物",@"生活",@"个人",@"家居",@"家庭",@"健身",@"办公",@"收入",@"其他"];
//NSArray *cou = @[@(20), @(10), @(10), @(15), @(28), @(12), @(11), @(15), @(10), @(12), @(9), @(10), @(7)];
//NSMutableString *strm = [[NSMutableString alloc] init];
//for (NSInteger i=2; i<arr.count + 2; i++) {
//    [strm appendFormat:@"<dict>\n"];
//    [strm appendFormat:@"<key>id</key>\n"];
//    [strm appendFormat:@"<integer>%ld</integer>\n", i];
//    [strm appendFormat:@"<key>name</key>\n"];
//    [strm appendFormat:@"<string>%@</string>\n", arr[i - 2]];
//    [strm appendFormat:@"<key>list</key>\n"];
//    [strm appendFormat:@"<array>\n"];
//    for (NSInteger y=1; y<=[cou[i-2] integerValue]; y++) {
//        [strm appendFormat:@"<dict>\n"];
//        [strm appendFormat:@"<key>id</key>\n"];
//        [strm appendFormat:@"<integer>%ld</integer>\n", Id];
//        [strm appendFormat:@"<key>section_id</key>\n"];
//        [strm appendFormat:@"<integer>%ld</integer>\n", i];
//        [strm appendFormat:@"<key>icon_n</key>\n"];
//        [strm appendFormat:@"<string>e_digital@3x.png</string>\n"];
//        [strm appendFormat:@"<key>icon_l</key>\n"];
//        [strm appendFormat:@"<string>e_digital_l@3x.png</string>\n"];
//        [strm appendFormat:@"<key>icon_s</key>\n"];
//        [strm appendFormat:@"<string>e_digital_s@3x.png</string>\n"];
//        [strm appendFormat:@"</dict>\n"];
//        Id += 1;
//    }
//    [strm appendFormat:@"</array>\n"];
//    [strm appendFormat:@"</dict>\n"];
//}
//NSLog(@"123");
