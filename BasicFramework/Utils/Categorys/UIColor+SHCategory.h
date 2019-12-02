//
//  UIColor+SHCategory.h
//  BasicFramework
//
//  Created by u1city on 2019/11/25.
//  Copyright © 2019 u1city. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (SHCategory)

/// 十六进制字符串转RGB
/// @param string 十六进制字符串
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
