//
//  SHBaseView.m
//  BasicFramework
//
//  Created by u1city on 2019/10/31.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseView.h"

@implementation SHBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self sh_settingView];
        [self sh_bindingViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    return [super init];
}

- (instancetype)initWithFrame:(CGRect)frame withViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    return [super initWithFrame:frame];
}

- (void)sh_settingView {}

- (void)sh_bindingViewModel {}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
