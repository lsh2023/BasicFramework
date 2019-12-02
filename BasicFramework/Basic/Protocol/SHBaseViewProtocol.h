//
//  SHBaseViewProtocol.h
//  BasicFramework
//
//  Created by u1city on 2019/10/31.
//  Copyright © 2019 u1city. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SHBaseViewModelProtocol;

@protocol SHBaseViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel;

- (instancetype)initWithFrame:(CGRect)frame withViewModel:(id<SHBaseViewModelProtocol>)viewModel;

- (void)sh_settingView;

- (void)sh_bindingViewModel;

@end

NS_ASSUME_NONNULL_END
