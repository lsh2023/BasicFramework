//
//  SHPhotographEditCollectionViewCell.m
//  BasicFramework
//
//  Created by u1city on 2019/12/10.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographEditCollectionViewCell.h"

@interface SHPhotographEditCollectionViewCell ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation SHPhotographEditCollectionViewCell

- (void)sh_settingView {
    self.contentView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (void)sh_bindingViewModel {
    
}

- (void)setAsset:(PHAsset *)asset {
    KWeakSelf
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc]init];
    // 采取同步获取图片（只获得一次图片）
    imageRequestOptions.synchronous = YES;
    imageRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height) contentMode:PHImageContentModeDefault options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.imageView.image = result;
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

@end
