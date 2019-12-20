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
@property (nonatomic,assign) CGFloat startOffsetX;
@property (nonatomic,strong) NSMutableArray *previewDataArray;

@end

@implementation SHPhotographEditView

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    self.viewModel = (SHPhotographViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)sh_settingView {
    self.backgroundColor = [UIColor blackColor];
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
    KWeakSelf
    [RACObserve(self.viewModel, selectPhotographArrayRow)subscribeNext:^(id  _Nullable x) {
        if (weakSelf.viewModel.photographArray.count > 0) {
            [weakSelf settingPhotographDataSource];
        }
    }];
}

- (void)setLocalIdentifier:(NSString *)localIdentifier {
    KWeakSelf
    if (self.previewDataArray.count > 0) {
        [self.previewDataArray removeAllObjects];
        [self settingPhotographDataSource];
    }
    
    if (localIdentifier) {
        SHPhotographModel *photographModel = self.viewModel.photographArray[self.viewModel.selectPhotographArrayRow];
        [photographModel.fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.localIdentifier isEqualToString:localIdentifier]) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
                [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                [weakSelf selectedAsset:idx];
                *stop = YES;
            }
        }];
    }else {
        PHFetchResult *fetchResult = [PHAsset fetchAssetsWithLocalIdentifiers:self.viewModel.selectAssetLocalIdentifierArray options:nil];
        [self.viewModel.selectAssetLocalIdentifierArray enumerateObjectsUsingBlock:^(NSString * _Nonnull localIdentifier, NSUInteger firstIdx, BOOL * _Nonnull firstStop) {
            [fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger secondIdx, BOOL * _Nonnull secondStop) {
                if ([obj.localIdentifier isEqualToString:localIdentifier]) {
                    [weakSelf.previewDataArray addObject:obj];
                    if (weakSelf.previewDataArray.count == self.viewModel.selectAssetLocalIdentifierArray.count) {
                        *secondStop = YES;
                        *firstStop = YES;
                        [weakSelf settingPhotographDataSource];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                            [weakSelf selectedAsset:0];
                        });
                    }
                }
            }];
        }];
    }
}

- (void)settingPhotographDataSource {
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.previewDataArray.count > 0) {
        return self.previewDataArray.count;
    }else {
        SHPhotographModel *photographModel = self.viewModel.photographArray[self.viewModel.selectPhotographArrayRow];
        return photographModel.fetchResult.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHPhotographEditCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KClassIdentifier forIndexPath:indexPath];
    PHAsset *asset;
    if (self.previewDataArray.count > 0) {
        asset = self.previewDataArray[indexPath.row];
    }else {
        SHPhotographModel *photographModel = self.viewModel.photographArray[self.viewModel.selectPhotographArrayRow];
        asset = photographModel.fetchResult[indexPath.row];
    }
    cell.asset = asset;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.headerView.hidden = !self.headerView.hidden;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat currentPageIndex = currentOffsetX / KScreen_Width;
    if (![NSObject isInteger:@(currentPageIndex)]) {
        if (_startOffsetX < currentOffsetX) { // 左滑图右
            if (currentOffsetX - _startOffsetX > KScreen_Width/2) { // 下一个的索引
                [self selectedAsset:currentPageIndex + 1];
            }else { // 当前的索引
                [self selectedAsset:currentPageIndex];
            }
        }else if (_startOffsetX > currentOffsetX) { // 右滑图左
            if (_startOffsetX - currentOffsetX > KScreen_Width/2) { // 下一个的索引
                [self selectedAsset:currentPageIndex];
            }else { // 当前的索引
                [self selectedAsset:currentPageIndex + 1];
            }
        }else { // 相等 当前的索引
            [self selectedAsset:currentPageIndex];
        }
    }else {
        [self selectedAsset:currentPageIndex];
    }
}

- (void)selectedAsset:(NSInteger)pageIndex {
    if (self.previewDataArray.count > 0) {
        if (pageIndex < self.previewDataArray.count) {
            PHAsset *asset = self.previewDataArray[pageIndex];
            self.headerView.localIdentifier = asset.localIdentifier;
            self.headerView.isSelect = [self.viewModel.selectAssetLocalIdentifierArray containsObject:asset.localIdentifier];
        }
    }else {
        SHPhotographModel *photographModel = self.viewModel.photographArray[self.viewModel.selectPhotographArrayRow];
        if (pageIndex < photographModel.fetchResult.count) {
            PHAsset *asset = photographModel.fetchResult[pageIndex];
            self.headerView.localIdentifier = asset.localIdentifier;
            self.headerView.isSelect = [self.viewModel.selectAssetLocalIdentifierArray containsObject:asset.localIdentifier];
        }
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(KScreen_Width,KScreen_Height-KGetSafeAreaInsetsHeight_Bottom);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
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

- (NSMutableArray *)previewDataArray {
    if (!_previewDataArray) {
        _previewDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _previewDataArray;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
