//
//  SHPhotographEditView.m
//  BasicFramework
//
//  Created by u1city on 2019/12/4.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographEditView.h"
#import "SHPhotographEditCollectionViewCell.h"
#import "SHPhotographViewModel.h"
#import "SHPhotographModel.h"
#import "SHPhotographEditHeaderView.h"

@interface SHPhotographEditView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) SHPhotographViewModel *viewModel;
@property (nonatomic,strong) SHPhotographEditHeaderView *headerView;

@end

@implementation SHPhotographEditView

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    self.viewModel = (SHPhotographViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)sh_settingView {
    [self addSubview:self.collectionView];
    [self addSubview:self.headerView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.offset(0);
        make.height.offset(KNavigationBarAndStatusBar_Height);
    }];
}

- (void)sh_bindingViewModel {
  
}

- (void)setLocalIdentifier:(NSString *)localIdentifier {
      [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SHPhotographModel *photographModel = self.viewModel.photographArray[section];
    return photographModel.fetchResult.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHPhotographEditCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KClassIdentifier forIndexPath:indexPath];
    SHPhotographModel *photographModel = self.viewModel.photographArray[indexPath.section];
    PHAsset *asset = photographModel.fetchResult[indexPath.row];
    cell.asset = asset;
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(KScreen_Width,KScreen_Height-KGetSafeAreaInsetsHeight_Bottom);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0.001;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[SHPhotographEditCollectionViewCell class] forCellWithReuseIdentifier:KClassIdentifier];
    }
    return _collectionView;
}

- (SHPhotographEditHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[SHPhotographEditHeaderView alloc]initWithViewModel:self.viewModel];
    }
    return _headerView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
