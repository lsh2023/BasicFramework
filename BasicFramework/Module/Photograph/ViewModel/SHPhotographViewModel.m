//
//  SHPhotographViewModel.m
//  BasicFramework
//
//  Created by u1city on 2019/11/4.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographViewModel.h"

@implementation SHPhotographViewModel

- (void)sh_bindingViewModel {
    
}

- (RACSubject *)actionSubject {
    if (!_actionSubject) {
        _actionSubject = [RACSubject subject];
    }
    return _actionSubject;
}

@end
