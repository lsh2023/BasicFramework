//
//  SHPhotographBottomView.m
//  BasicFramework
//
//  Created by u1city on 2019/11/27.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographBottomView.h"
#import "SHPhotographViewModel.h"

@interface SHPhotographBottomView ()

@property (nonatomic,strong) UIButton *previewButton;
@property (nonatomic,strong) UIButton *editButton;
@property (nonatomic,strong) UIButton *determineButton;
@property (nonatomic,strong) SHPhotographViewModel *viewModel;

@end

@implementation SHPhotographBottomView

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    self.viewModel = viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)sh_settingView {
    self.backgroundColor = KHexColor(@"ececec");
    [self addSubview:self.previewButton];
    [self addSubview:self.editButton];
    [self addSubview:self.determineButton];
    [self.previewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.bottom.equalTo(self);
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.previewButton.mas_right).offset(30);
        make.top.bottom.equalTo(self);
    }];
    [self.determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)sh_bindingViewModel {
    KWeakSelf
    [[self.previewButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.viewModel.actionSubject sendNext:[RACTuple tupleWithObjects:@(PhotographActionSubjectType_Preview), nil]];
    }];
    
    [[self.editButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.viewModel.actionSubject sendNext:[RACTuple tupleWithObjects:@(PhotographActionSubjectType_Edit), nil]];
    }];
    
    [[self.determineButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.viewModel.actionSubject sendNext:[RACTuple tupleWithObjects:@(PhotographActionSubjectType_Determine), nil]];
    }];
    
    [RACObserve(self,viewModel.selectAssetLocalIdentifierArray) subscribeNext:^(id  _Nullable x) {
        weakSelf.editButton.selected = weakSelf.viewModel.selectAssetLocalIdentifierArray.count == 1;
        weakSelf.previewButton.selected = weakSelf.viewModel.selectAssetLocalIdentifierArray.count > 0;
        weakSelf.determineButton.selected = weakSelf.viewModel.selectAssetLocalIdentifierArray.count > 0;
        weakSelf.editButton.userInteractionEnabled = weakSelf.editButton.selected;
        weakSelf.previewButton.userInteractionEnabled = weakSelf.previewButton.selected;
        weakSelf.determineButton.userInteractionEnabled = weakSelf.determineButton.selected;
        [weakSelf.determineButton setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)weakSelf.viewModel.selectAssetLocalIdentifierArray.count] forState:UIControlStateSelected];
    }];
}

- (UIButton *)previewButton {
    if (!_previewButton) {
        _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _previewButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_previewButton setTitle:@"预览" forState:UIControlStateNormal];
        [_previewButton setTitleColor:KHexColor(@"999999") forState:UIControlStateNormal];
        [_previewButton setTitleColor:KHexColor(@"333333") forState:UIControlStateSelected];
    }
    return _previewButton;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:KHexColor(@"999999") forState:UIControlStateNormal];
        [_editButton setTitleColor:KHexColor(@"333333") forState:UIControlStateSelected];
    }
    return _editButton;
}

- (UIButton *)determineButton {
    if (!_determineButton) {
        _determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _determineButton.layer.masksToBounds = YES;
        _determineButton.layer.cornerRadius = 15;
        _determineButton.backgroundColor = [UIColor cyanColor];
        [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
        [_determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _determineButton;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
