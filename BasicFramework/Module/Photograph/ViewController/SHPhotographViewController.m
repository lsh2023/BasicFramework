//
//  SHPhotographViewController.m
//  BasicFramework
//
//  Created by u1city on 2019/11/4.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographViewController.h"
#import "SHPhotographModel.h"
#import "SHPhotographViewModel.h"
#import "SHPhotographCollectionView.h"
#import "SHPhotographListTableView.h"

@interface SHPhotographViewController () 

@property (nonatomic,strong) SHPhotographCollectionView *photographCollectionView;
@property (nonatomic,strong) SHPhotographListTableView *photographListTableView;
@property (nonatomic,strong) SHPhotographViewModel *viewModel;
@property (nonatomic,strong) UIButton *leftButton;

@end

@implementation SHPhotographViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)sh_settingView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.photographListTableView];
    [self.view addSubview:self.photographCollectionView];
    
    [self.photographListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-KGetSafeAreaInsetsHeight_Bottom);
    }];
    
    [self.photographCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.mas_offset(KScreen_Width);
        make.bottom.equalTo(self.view.mas_bottom).offset(-KGetSafeAreaInsetsHeight_Bottom);
    }];
    
}

- (void)sh_bindingViewModel {
    KWeakSelf
    
    [self.viewModel getPhotographData:^{
        if (weakSelf.viewModel.photographArray.count > 0) {
            SHPhotographModel *photographModel = weakSelf.viewModel.photographArray[0];
            weakSelf.title = photographModel.localizedTitle;
            [weakSelf.photographListTableView settingPhotographDataSource];
            [weakSelf.photographCollectionView settingPhotographDataSource:[NSMutableArray arrayWithObject:photographModel]];
        }
    }];
    
    [self.viewModel.actionSubject subscribeNext:^(RACTuple *tuple) {
        if ([tuple.first intValue] == PhotographActionSubjectType_PhotographList) {
            NSInteger row = [tuple.second integerValue];
            SHPhotographModel *photographModel = weakSelf.viewModel.photographArray[row];
            weakSelf.title = photographModel.localizedTitle;
            [weakSelf.photographCollectionView settingPhotographDataSource:[NSMutableArray arrayWithObject:photographModel]];
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.leftButton.alpha = 1;
                [weakSelf.photographCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(0);
                }];
                [weakSelf.view layoutIfNeeded];
            }];
        }
    }];
}

- (void)sh_settingNavigationView {
    KWeakSelf
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setImage:[UIImage imageNamed:@"img_leftArrow"] forState:UIControlStateNormal];
    [[_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        weakSelf.title = @"照片";
        [UIView animateWithDuration:0.3 animations:^{
            x.alpha = 0;
            [weakSelf.photographCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.offset(KScreen_Width);
            }];
            [weakSelf.view layoutIfNeeded];
        }];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

- (SHPhotographCollectionView *)photographCollectionView {
    if (!_photographCollectionView) {
        _photographCollectionView = [[SHPhotographCollectionView alloc]initWithViewModel:self.viewModel];
    }
    return _photographCollectionView;
}

- (SHPhotographListTableView *)photographListTableView {
    if (!_photographListTableView) {
        _photographListTableView = [[SHPhotographListTableView alloc]initWithViewModel:self.viewModel];
    }
    return _photographListTableView;
}

- (SHPhotographViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SHPhotographViewModel alloc]init];
    }
    return _viewModel;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
