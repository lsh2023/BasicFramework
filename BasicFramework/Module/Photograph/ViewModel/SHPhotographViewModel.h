//
//  SHPhotographViewModel.h
//  BasicFramework
//
//  Created by u1city on 2019/11/4.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPhotographViewModel : SHBaseViewModel

@property (nonatomic,strong) RACSubject *actionSubject;

@property (nonatomic,strong,readonly) NSMutableArray *photographArray;

@property (nonatomic,strong,readwrite) NSMutableArray *selectAssetLocalIdentifierArray;

/// 获取相册数据
/// @param successHandler 成功处理程序
- (void)getPhotographData:(void (^)(void))successHandler;

@end

NS_ASSUME_NONNULL_END
