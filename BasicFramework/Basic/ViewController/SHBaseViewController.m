//
//  SHBaseViewController.m
//  BasicFramework
//
//  Created by u1city on 2019/10/31.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHBaseViewController.h"

@interface SHBaseViewController ()

@end

@implementation SHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (instancetype)init {
    if (self = [super init]) {
        [self sh_settingView];
        [self sh_bindingViewModel];
        [self sh_settingNavigationView];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    return [super init];
}

- (void)sh_settingView {}

- (void)sh_bindingViewModel {}

- (void)sh_settingNavigationView {}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
