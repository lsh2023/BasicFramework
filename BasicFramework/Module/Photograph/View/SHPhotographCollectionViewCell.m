//
//  SHPhotographCollectionViewCell.m
//  BasicFramework
//
//  Created by u1city on 2019/11/20.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographCollectionViewCell.h"

@interface SHPhotographCollectionViewCell ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *selectButton;

@end

@implementation SHPhotographCollectionViewCell

- (void)sh_settingView {
    [self.contentView addSubview:self.imageView];
    [self.imageView addSubview:self.selectButton];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_top).offset(5);
        make.right.equalTo(self.imageView.mas_right).offset(-5);
        make.width.mas_offset(self.selectButton.imageView.image.size.width);
        make.height.mas_offset(self.selectButton.imageView.image.size.height);
    }];
}

- (void)setAsset:(PHAsset *)asset {
    KWeakSelf
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc]init];
    // 采取同步获取图片（只获得一次图片）
    imageRequestOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height) contentMode:PHImageContentModeDefault options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.imageView.image = result;
    }];
}

- (void)sh_bindingViewModel {
//    KWeakSelf
    [[self.selectButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected = !x.selected;
//        [weakSelf.viewModel.actionSubject sendNext:[RACTuple tupleWithObjects:@(PhotographActionSubjectType_SelectPhotograph),weakSelf.indexPath, nil]];
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
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
