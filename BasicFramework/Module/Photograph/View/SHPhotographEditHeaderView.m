//
//  SHPhotographEditHeaderView.m
//  BasicFramework
//
//  Created by u1city on 2019/12/10.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographEditHeaderView.h"
#import "SHPhotographViewModel.h"

@interface SHPhotographEditHeaderView ()

@property (nonatomic,strong) UIButton *leftButton;

@property (nonatomic,strong) UIButton *selectButton;

@property (nonatomic,strong) SHPhotographViewModel *viewModel;

@end

@implementation SHPhotographEditHeaderView

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    self.viewModel = (SHPhotographViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setIsSelect:(BOOL)isSelect {
    self.selectButton.selected = isSelect;
}

- (void)sh_settingView {
    self.backgroundColor = KHexColor(@"1A1A1A");
    [self addSubview:self.leftButton];
    [self addSubview:self.selectButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(KStatusBar_Height);
        make.width.mas_offset(24);
        make.height.mas_offset(KNavigationBar_Height);
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(self.leftButton.mas_centerY);
        make.width.mas_offset(self.selectButton.imageView.image.size.width);
        make.height.mas_offset(self.selectButton.imageView.image.size.height);
    }];
}

- (void)sh_bindingViewModel {
    KWeakSelf
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        RACTuple *tuple = [RACTuple tupleWithObjects:@(PhotographActionSubjectType_PhotographEditBack), nil];
        [weakSelf.viewModel.actionSubject sendNext:tuple];
    }];
    
    [[self.selectButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected = !x.selected;
        [weakSelf.viewModel.actionSubject sendNext:[RACTuple tupleWithObjects:@(PhotographActionSubjectType_SelectPhotograph),weakSelf.localIdentifier, nil]];
    }];
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"img_leftArrow_white"] forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"img_unSelect"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"img_select"] forState:UIControlStateSelected];
    }
    return _selectButton;
}

@end
