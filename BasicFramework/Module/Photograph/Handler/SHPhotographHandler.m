//
//  SHPhotographHandler.m
//  BasicFramework
//
//  Created by u1city on 2019/11/14.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographHandler.h"
#import <Photos/Photos.h>
#import "SHPhotographModel.h"

@implementation SHPhotographHandler

+ (SHPhotographHandler *)shareInstance {
    static SHPhotographHandler *photographHandler;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        photographHandler = [[SHPhotographHandler alloc]init];
    });
    return photographHandler;
}

- (void)getPhotographData:(void (^)(NSMutableArray *photographArray))successHandler {
    [self getAuthorizationStatus:^{
        NSMutableArray *photoArray = [NSMutableArray arrayWithCapacity:0];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            //        PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
            PHFetchResult<PHAssetCollection *> *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                                       subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                                                       options:nil];
            [fetchResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SHPhotographModel *photographModel = [[SHPhotographModel alloc]init];
                photographModel.localizedTitle = obj.localizedTitle;
                photographModel.fetchResult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
                [photoArray addObject:photographModel];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successHandler) {
                    successHandler(photoArray);
                }
            });
        });
    }];
}


/// 获取授权状态
/// @param successHandler 成功执行
- (void)getAuthorizationStatus:(void (^)(void))successHandler {
    KWeakSelf
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    switch (authorizationStatus) {
        case PHAuthorizationStatusNotDetermined: { // 用户尚未对此应用程序进行选择
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                [weakSelf getAuthorizationStatus:successHandler];
            }];
        }
            break;
        case PHAuthorizationStatusRestricted: { //此应用程序无权访问照片数据。由于活动限制，用户无法更改此应用程序的状态，例如已设置家长控制。
            
        }
            break;
        case PHAuthorizationStatusDenied: { // 用户已明确拒绝此应用程序访问照片数据。
            
        }
            break;
        case PHAuthorizationStatusAuthorized: { // 用户已授权此应用程序访问照片数据。
            if (successHandler) {
                successHandler();
            }
        }
            break;
        default:
            break;
    }
}


@end
