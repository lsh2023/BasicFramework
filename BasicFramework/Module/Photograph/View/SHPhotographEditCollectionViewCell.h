//
//  SHPhotographEditCollectionViewCell.h
//  BasicFramework
//
//  Created by u1city on 2019/12/10.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseCollectionViewCell.h"
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHPhotographEditCollectionViewCell : SHBaseCollectionViewCell

@property (nonatomic,strong) PHAsset *asset;

@end

NS_ASSUME_NONNULL_END
