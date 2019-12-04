//
//  SHPhotographViewModel.m
//  BasicFramework
//
//  Created by u1city on 2019/11/4.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographViewModel.h"
#import "SHPhotographHandler.h"

@implementation SHPhotographViewModel

- (void)sh_bindingViewModel {
    
}

- (RACSubject *)actionSubject {
    if (!_actionSubject) {
        _actionSubject = [RACSubject subject];
    }
    return _actionSubject;
}

- (void)getPhotographData:(void (^)(void))successHandler {
    [[SHPhotographHandler shareInstance]getPhotographData:^(NSMutableArray * _Nonnull photographArray) {
        self->_photographArray = photographArray;
        if (successHandler) {
            successHandler();
        }
    }];
}

- (NSMutableArray *)selectAssetLocalIdentifierArray {
    if (!_selectAssetLocalIdentifierArray) {
        _selectAssetLocalIdentifierArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectAssetLocalIdentifierArray;
}

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

@end
