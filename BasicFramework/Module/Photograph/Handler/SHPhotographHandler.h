//
//  SHPhotographHandler.h
//  BasicFramework
//
//  Created by u1city on 2019/11/14.
//  Copyright © 2019 u1city. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHPhotographHandler : NSObject

+ (SHPhotographHandler *)shareInstance;

- (void)getPhotographData:(void (^)(NSMutableArray *photographArray))successHandler;

@end

NS_ASSUME_NONNULL_END
