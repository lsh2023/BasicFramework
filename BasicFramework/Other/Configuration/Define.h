//
//  Define.h
//  BasicFramework
//
//  Created by u1city on 2019/11/14.
//  Copyright © 2019 u1city. All rights reserved.
//

#ifndef Define_h
#define Define_h

///  弱引用
#define KWeakSelf __weak __typeof(self) weakSelf = self;

/// 十六进制字符串转RGB
#define KHexColor(c) [UIColor colorWithHexString:(c) alpha:1]

/// 类识别码
#define KClassIdentifier NSStringFromClass([self class])

/// 状态栏高度
#define KStatusBar_Height [UIApplication sharedApplication].statusBarFrame.size.height

/// 导航条高度
#define KNavigationBar_Height 44.0

///  导航栏和状态栏总高度
#define KNavigationBarAndStatusBar_Height KNavigationBar_Height + KStatusBar_Height

/// 屏幕的宽度
#define KScreen_Width [UIScreen mainScreen].bounds.size.width

/// 屏幕的高度
#define KScreen_Height [UIScreen mainScreen].bounds.size.height

/// 获取窗口
#define KGetWindow [UIApplication sharedApplication].delegate.window

/// 获取安全区域插图高度（顶部）
#define KGetSafeAreaInsetsHeight_Top \
({CGFloat safeAreaInsetsTop = 0.0;\
if (@available(iOS 11.0, *)) {\
    safeAreaInsetsTop = KGetWindow.safeAreaInsets.top;\
}\
(safeAreaInsetsTop);})

/// 获取安全区域插图高度（底部）
#define KGetSafeAreaInsetsHeight_Bottom \
({CGFloat safeAreaInsetsBottom = 0.0;\
if (@available(iOS 11.0, *)) {\
    safeAreaInsetsBottom = KGetWindow.safeAreaInsets.bottom;\
}\
(safeAreaInsetsBottom);})

/// 是否有安全区域插图
#define KIsSafeAreaInsets KGetSafeAreaInsetsHeight_Top > 0 && KGetSafeAreaInsetsHeight_Bottom > 0

#endif /* Define_h */
