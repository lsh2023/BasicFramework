//
//  SHPhotographModel.h
//  BasicFramework
//
//  Created by u1city on 2019/11/20.
//  Copyright © 2019 u1city. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHPhotographModel : NSObject

/// 本地标题
@property (nonatomic, strong, nullable) NSString *localizedTitle;

/// 获取结果：从每一个相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
@property (nonatomic, strong, nullable)PHFetchResult<PHAsset *> *fetchResult;

@end

NS_ASSUME_NONNULL_END
