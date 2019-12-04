//
//  SHPhotographListTableView.m
//  BasicFramework
//
//  Created by u1city on 2019/11/22.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographListTableView.h"
#import "SHPhotographListTableViewCell.h"
#import "SHPhotographModel.h"
#import "SHPhotographViewModel.h"

@interface SHPhotographListTableView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) SHPhotographViewModel *viewModel;

@end

@implementation SHPhotographListTableView

- (instancetype)initWithViewModel:(id<SHBaseViewModelProtocol>)viewModel {
    self.viewModel = (SHPhotographViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)sh_settingView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)sh_bindingViewModel {
  
}

- (void)settingPhotographDataSource {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.viewModel.photographArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHPhotographListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KClassIdentifier forIndexPath:indexPath];
    SHPhotographModel *photographModel = self.viewModel.photographArray[indexPath.row];
    cell.photographModel = photographModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.actionSubject sendNext:[RACTuple tupleWithObjects:@(PhotographActionSubjectType_PhotographList),@(indexPath.row), nil]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[SHPhotographListTableViewCell class] forCellReuseIdentifier:KClassIdentifier];
    }
    return _tableView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
