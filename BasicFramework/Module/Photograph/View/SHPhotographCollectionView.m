//
//  SHPhotographCollectionView.m
//  BasicFramework
//
//  Created by u1city on 2019/11/22.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographCollectionView.h"
#import "SHPhotographModel.h"
#import "SHPhotographViewModel.h"
#import "SHPhotographCollectionViewCell.h"
#import "SHPhotographCollectionReusableView.h"
#import "SHPhotographBottomView.h"

static NSString *collectionSectionHeader = @"CollectionElementKindSectionHeader";
static NSString *collectionSectionFooter = @"CollectionElementKindSectionFooter";

@interface SHPhotographCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *photographArray;
@property (nonatomic,strong) SHPhotographBottomView *bottomView;
@property (nonatomic,strong) SHPhotographViewModel *viewModel;

@end

@implementation SHPhotographCollectionView

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    self.viewModel = (SHPhotographViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)sh_settingView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self addSubview:self.bottomView];
    
    CGFloat bottomViewHeight = 50;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.offset(-bottomViewHeight);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-KGetSafeAreaInsetsHeight_Bottom);
        make.height.offset(bottomViewHeight);
    }];

}

- (void)sh_bindingViewModel {
    KWeakSelf
    [self.viewModel.actionSubject subscribeNext:^(RACTuple *tuple) {
        if ([tuple.first intValue] == PhotographActionSubjectType_SelectPhotograph) {
            NSString *localIdentifier = tuple.second;
            if (![weakSelf.viewModel.selectAssetLocalIdentifierArray containsObject:localIdentifier]) {
                // mutableArrayValueForKey 使用这种方式添加删除数组数据，数据变化可以被RAC/KVO监听
                [[weakSelf.viewModel mutableArrayValueForKey:@"selectAssetLocalIdentifierArray"]addObject:localIdentifier];
            }else {
                [[weakSelf.viewModel mutableArrayValueForKey:@"selectAssetLocalIdentifierArray"]removeObject:localIdentifier];
            }
        }
    }];
}

- (void)settingPhotographDataSource:(NSMutableArray *)photographArray {
    self.photographArray = photographArray;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SHPhotographModel *photographModel = self.photographArray[section];
    return photographModel.fetchResult.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHPhotographCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KClassIdentifier forIndexPath:indexPath];
    SHPhotographModel *photographModel = self.photographArray[indexPath.section];
    PHAsset *asset = photographModel.fetchResult[indexPath.row];
    cell.asset = asset;
    cell.viewModel = self.viewModel;
    cell.isSelect = [self.viewModel.selectAssetLocalIdentifierArray containsObject:asset.localIdentifier];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SHPhotographModel *photographModel = self.photographArray[indexPath.section];
    PHAsset *asset = photographModel.fetchResult[indexPath.row];
    RACTuple *tuple = [RACTuple tupleWithObjects:@(PhotographActionSubjectType_Preview),asset.localIdentifier, nil];
    [self.viewModel.actionSubject sendNext:tuple];
}
 
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionFooter) {
        SHPhotographCollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionSectionFooter forIndexPath:indexPath];
        SHPhotographModel *photographModel = self.photographArray[indexPath.section];
        collectionReusableView.text = [NSString stringWithFormat:@"共%lu张照片",(unsigned long)photographModel.fetchResult.count];
        return collectionReusableView;
    }
    UICollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionSectionHeader forIndexPath:indexPath];
    return collectionReusableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat selfWidth = KScreen_Width;
        CGFloat itemWidth = (selfWidth - 5)/4;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(itemWidth,itemWidth);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
        flowLayout.headerReferenceSize = CGSizeZero;
        flowLayout.footerReferenceSize = CGSizeMake(selfWidth, 30);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SHPhotographCollectionViewCell class] forCellWithReuseIdentifier:KClassIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionSectionHeader];
        [_collectionView registerClass:[SHPhotographCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionSectionFooter];
    }
    return _collectionView;
}

- (SHPhotographBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SHPhotographBottomView alloc]initWithViewModel:self.viewModel];
    }
    return _bottomView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
