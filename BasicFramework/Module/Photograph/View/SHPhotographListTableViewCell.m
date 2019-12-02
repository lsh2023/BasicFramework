//
//  SHPhotographListTableViewCell.m
//  BasicFramework
//
//  Created by u1city on 2019/11/22.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "SHPhotographListTableViewCell.h"

@interface SHPhotographListTableViewCell ()

@property (nonatomic,strong) UIImageView *thumbnailImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) UIView *separatorView;

@end

@implementation SHPhotographListTableViewCell

- (void)sh_settingView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.thumbnailImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightArrow];
    [self.contentView addSubview:self.separatorView];
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(60);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumbnailImageView.mas_right).offset(15);
        make.top.bottom.equalTo(self.contentView);
        make.width.lessThanOrEqualTo(@(KScreen_Width-self.rightArrow.image.size.width-50));
    }];
    
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_offset(self.rightArrow.image.size.width);
        make.height.mas_offset(self.rightArrow.image.size.height);
    }];
    
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.bottom.equalTo(self.contentView);
        make.height.offset(0.5);
    }];
    
}

- (void)sh_bindingViewModel {
    
}

- (void)setPhotographModel:(SHPhotographModel *)photographModel {
    KWeakSelf
    if (photographModel.fetchResult.count > 0) {
        PHAsset *asset = photographModel.fetchResult[0];
        PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc]init];
        // 采取同步获取图片（只获得一次图片）
        imageRequestOptions.synchronous = YES;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height) contentMode:PHImageContentModeDefault options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            weakSelf.thumbnailImageView.image = result;
        }];
    }else {
        weakSelf.thumbnailImageView.image = [UIImage imageNamed:@"img_defaultImage"];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@（%lu）",photographModel.localizedTitle,(unsigned long)photographModel.fetchResult.count];
}

- (UIImageView *)thumbnailImageView {
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc]init];
    }
    return _thumbnailImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor darkTextColor];
    }
    return _titleLabel;
}

- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc]init];
        _rightArrow.image = [UIImage imageNamed:@"img_rightArrow"];
    }
    return _rightArrow;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc]init];
        _separatorView.backgroundColor = KHexColor(@"ececec");
    }
    return _separatorView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
