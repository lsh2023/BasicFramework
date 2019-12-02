//
//  SHBaseViewModel.m
//  BasicFramework
//
//  Created by u1city on 2019/10/31.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseViewModel.h"

@implementation SHBaseViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self sh_bindingViewModel];
    }
    return self;
}

- (void)sh_bindingViewModel {}

@end
