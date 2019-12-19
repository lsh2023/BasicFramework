//
//  SHPhotographEditView.h
//  BasicFramework
//
//  Created by u1city on 2019/12/4.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPhotographEditView : SHBaseView

@property (nonatomic,copy) NSString *localIdentifier;

/// 设置相册数据源
- (void)settingPhotographDataSource;

@end

NS_ASSUME_NONNULL_END
