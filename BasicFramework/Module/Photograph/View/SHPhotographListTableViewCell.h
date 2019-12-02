//
//  SHPhotographListTableViewCell.h
//  BasicFramework
//
//  Created by u1city on 2019/11/22.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseTableViewCell.h"
#import "SHPhotographModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPhotographListTableViewCell : SHBaseTableViewCell

@property (nonatomic,strong) SHPhotographModel *photographModel;

@end

NS_ASSUME_NONNULL_END
