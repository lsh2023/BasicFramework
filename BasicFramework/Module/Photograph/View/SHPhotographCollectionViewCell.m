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
@property (nonatomic,copy) NSString *localIdentifier;

@end

@implementation SHPhotographCollectionViewCell

- (void)sh_settingView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.imageView];
    [self.imageView addSubview:self.selectButton];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_top).offset(5);
        make.right.equalTo(self.imageView.mas_right).offset(-5);
        make.width.mas_offset(self.selectButton.currentBackgroundImage.size.width);
        make.height.mas_offset(self.selectButton.currentBackgroundImage.size.height);
    }];
}

- (void)setAsset:(PHAsset *)asset {
    KWeakSelf
    _localIdentifier = asset.localIdentifier;
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc]init];
    // 采取同步获取图片（只获得一次图片）
    imageRequestOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height) contentMode:PHImageContentModeDefault options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.imageView.image = result;
    }];
}

- (void)setIsSelect:(BOOL)isSelect {
    self.selectButton.selected = isSelect;
}

- (void)sh_bindingViewModel {
    KWeakSelf
    [[self.selectButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected = !x.selected;
        [weakSelf.viewModel.actionSubject sendNext:[RACTuple tupleWithObjects:@(PhotographActionSubjectType_SelectPhotograph),weakSelf.localIdentifier, nil]];
    }];
    
    [RACObserve(self.selectButton, selected) subscribeNext:^(id  _Nullable x) {
        if (weakSelf.selectButton.selected) {
            [weakSelf.viewModel.selectAssetLocalIdentifierArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:weakSelf.localIdentifier]) {
                    [weakSelf.selectButton setTitle:[NSString stringWithFormat:@"%ld",idx + 1] forState:UIControlStateNormal];
                    *stop = YES;
                }
            }];
        }else {
            [weakSelf.selectButton setTitle:@"" forState:UIControlStateNormal];
        }
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
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"img_unSelect"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"img_select"] forState:UIControlStateSelected];
        [_selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _selectButton;
}

@end
