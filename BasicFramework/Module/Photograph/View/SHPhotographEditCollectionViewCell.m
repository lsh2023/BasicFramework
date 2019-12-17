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
    imageRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    imageRequestOptions.networkAccessAllowed = YES;
    
    if (@available(iOS 13, *)) {
        [[PHCachingImageManager defaultManager] requestImageDataAndOrientationForAsset:asset options:imageRequestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, CGImagePropertyOrientation orientation, NSDictionary * _Nullable info) {
            [weakSelf setImageViewDataWithImageData:imageData];
        }];
    } else {
        [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            [weakSelf setImageViewDataWithImageData:imageData];
        }];
    }
}

- (void)setImageViewDataWithImageData:(NSData * _Nullable)imageData {
    if (imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        self.imageView.image = image;
        
        CGFloat currentW = self.contentView.frame.size.width;
        CGFloat currentH = self.contentView.frame.size.height;
        
        CGFloat maximumHeight;
        if (image.size.width < image.size.height) {
            maximumHeight = currentH * (currentW/currentH);
        }else {
            maximumHeight = currentW * (currentW/currentH);
        }
        
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.lessThanOrEqualTo(@(currentW));
            make.height.lessThanOrEqualTo(@(maximumHeight));
        }];
    }
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

@end
