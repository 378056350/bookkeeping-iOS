/**
 * 拍照
 * @author 郑业强 2018-12-26 创建文件
 */

#import "ZLPhotoActionSheet+Extension.h"

@implementation ZLPhotoActionSheet (Extension)

+ (ZLPhotoActionSheet *)getNormalDefault {
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
#pragma mark - 参数配置 optional，可直接使用 defaultPhotoConfiguration
    actionSheet.configuration.hideClipRatiosToolBar = true;
    actionSheet.configuration.sortAscending = true;
    actionSheet.configuration.allowSelectImage = true;
    actionSheet.configuration.allowSelectGif = false;
    actionSheet.configuration.allowSelectVideo = false;
    actionSheet.configuration.allowSelectLivePhoto = true;
    actionSheet.configuration.allowForceTouch = true;
    actionSheet.configuration.allowEditImage = true;
    actionSheet.configuration.allowEditVideo = false;
    actionSheet.configuration.allowSlideSelect = true;
    actionSheet.configuration.allowMixSelect = true;
    actionSheet.configuration.allowDragSelect = false;
    actionSheet.configuration.allowTakePhotoInLibrary = true;
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = true;
    actionSheet.configuration.maxPreviewCount = 20;
    actionSheet.configuration.clipRatios = @[GetClipRatio(1, 1)];
    actionSheet.configuration.maxSelectCount = 1;
    actionSheet.configuration.cellCornerRadio = 0;
    actionSheet.configuration.showSelectBtn = false;
    actionSheet.configuration.editAfterSelectThumbnailImage = false;
    // 是否在已选择照片上显示遮罩层
    actionSheet.configuration.showSelectedMask = false;
    // 颜色，状态栏样式
    actionSheet.configuration.navBarColor = kColor_Main_Color;
    actionSheet.configuration.navTitleColor = kColor_Text_Black;
    actionSheet.configuration.bottomBtnsNormalTitleColor = kColor_Main_Color;
    actionSheet.configuration.bottomViewBgColor = kColor_BG;
    actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    // 是否允许框架解析图片
    actionSheet.configuration.shouldAnialysisAsset = true;
    actionSheet.configuration.languageType = ZLLanguageChineseSimplified;
#pragma mark - required
    return actionSheet;
}

@end
