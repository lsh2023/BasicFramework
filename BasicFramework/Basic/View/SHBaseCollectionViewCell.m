//
//  SHBaseCollectionViewCell.m
//  BasicFramework
//
//  Created by u1city on 2019/11/20.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseCollectionViewCell.h"

@implementation SHBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self sh_settingView];
        [self sh_bindingViewModel];
    }
    return self;
}

- (void)sh_settingView {}

- (void)sh_bindingViewModel {}


@end
