//
//  SHPhotographCollectionView.h
//  BasicFramework
//
//  Created by u1city on 2019/11/22.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPhotographCollectionView : SHBaseView

/// 设置相册数据源
/// @param photographArray 相册数组
- (void)settingPhotographDataSource:(NSMutableArray *)photographArray;

@end

NS_ASSUME_NONNULL_END
