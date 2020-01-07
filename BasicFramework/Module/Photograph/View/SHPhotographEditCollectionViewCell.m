//
//  SHPhotographEditCollectionViewCell.m
//  BasicFramework
//
//  Created by u1city on 2019/12/10.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographEditCollectionViewCell.h"

@interface SHPhotographEditCollectionViewCell () <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation SHPhotographEditCollectionViewCell

- (void)sh_settingView {
    self.backgroundColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
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
        CGFloat imageScale = image.size.width / image.size.height;
        CGFloat maxScale = KScreen_Width / KScreen_Height;
        CGFloat imageW,imageH;
        if (imageScale < maxScale) {
            CGFloat scale = KScreen_Height/image.size.height;
            imageW = scale * image.size.width;
            imageH = KScreen_Height;
        }else {
            CGFloat scale = KScreen_Width/image.size.width;
            imageW =  KScreen_Width;
            imageH = scale * image.size.height;
        }
        
        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.scrollView);
            make.width.lessThanOrEqualTo(@(imageW));
            make.height.lessThanOrEqualTo(@(imageH));
        }];
        
//        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.contentView);
//            make.width.height.equalTo(self.imageView);
//        }];
        
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
//    CGRect frame = self.imageView.frame;
//
//    frame.origin.y = (self.scrollView.frame.size.height - self.imageView.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.imageView.frame.size.height) * 0.5 : 0;
//    frame.origin.x = (self.scrollView.frame.size.width - self.imageView.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.imageView.frame.size.width) * 0.5 : 0;
//    self.imageView.frame = frame;
//
//    self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
    
//    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.scrollView).centerOffset(CGPointMake(-600, -600));
//    }];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        //        _scrollView.scrollEnabled = NO;
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 5;
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

@end
