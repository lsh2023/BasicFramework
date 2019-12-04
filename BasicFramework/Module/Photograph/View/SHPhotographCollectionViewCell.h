//
//  SHPhotographCollectionViewCell.h
//  BasicFramework
//
//  Created by u1city on 2019/11/20.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseCollectionViewCell.h"
#import <Photos/Photos.h>
#import "SHPhotographViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPhotographCollectionViewCell : SHBaseCollectionViewCell

@property (nonatomic,strong) PHAsset *asset;

@property (nonatomic,strong) SHPhotographViewModel *viewModel;

@property (nonatomic,assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
