//
//  SHPhotographCollectionReusableView.m
//  BasicFramework
//
//  Created by u1city on 2019/11/21.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographCollectionReusableView.h"

@interface SHPhotographCollectionReusableView ()

@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation SHPhotographCollectionReusableView

- (void)sh_settingView {
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setText:(NSString *)text {
   self.textLabel.text = text;
}

- (void)sh_bindingViewModel {
    
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = [UIColor darkTextColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:14];
    }
    return _textLabel;
}


@end
