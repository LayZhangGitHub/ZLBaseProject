//
//  MineHeaderCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MineHeaderCell.h"
#import "UserInfoService.h"
#import "TMMineInfoModel.h"

@interface MineHeaderCell()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UIButton *topUpButton;
@property (nonatomic, strong) UILabel *balanceLabel;
@end

@implementation MineHeaderCell
#pragma mark - override
- (void)initCellComponent {
    self.backgroundColor = ZLRedColor;
    [self cellAddSubview:self.avatarImageView];
    [self cellAddSubview:self.nameLabel];
    [self cellAddSubview:self.moreImageView];
    [self cellAddSubview:self.topUpButton];
    [self cellAddSubview:self.balanceLabel];
    
    [self bk_whenTapped:^{
        [[ZLNavigationService sharedService] openUrl:LocalAppHost(SettingHost)];
    }];
}

- (void)reloadData {
    self.avatarImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    
    if ([UserInfoService shareUserInfo].userInfo.isLogin) {
        self.avatarImageView.hidden = NO;
        if ([[UserInfoService shareUserInfo].userInfo.avatar isNotEmptyString]) {
            [self.avatarImageView setOnlineImage:[UserInfoService shareUserInfo].userInfo.avatar
                                placeHolderImage:[UIImage imageNamed:@"mine_default_avatar"]];
        }else{
            self.avatarImageView.image = [UIImage imageNamed:@"mine_default_avatar"];
        }
        
        self.nameLabel.hidden = NO;
        self.nameLabel.text = [UserInfoService shareUserInfo].userInfo.name;
        [self.nameLabel sizeToFit];
        
        if (self.cellData) {
            TMMineInfoModel *model = self.cellData;
            NSString *balance = [NSString stringWithFormat:@"夺宝币：%@",model.coins];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:balance];
            [attr addAttribute:NSForegroundColorAttributeName value:ZLGray(45) range:NSMakeRange(4, model.coins.length)];
            self.balanceLabel.attributedText = attr;
            [self.balanceLabel sizeToFit];
        }
    }
    
    if (self.showLuck) {
        self.topUpButton.hidden = NO;
        self.balanceLabel.hidden = NO;
    }else{
        self.topUpButton.hidden = YES;
        self.balanceLabel.hidden = YES;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    return @116;
}

#pragma mark - properties
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 35.0f;
        _avatarImageView.userInteractionEnabled = YES;
        [_avatarImageView bk_whenTapped:^{
            [[ZLNavigationService sharedService] openUrl:LocalAppHost(SettingHost)];
        }];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = ZLWhiteColor;
        _nameLabel.font = ZLNormalFont(16);
    }
    return _nameLabel;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"more_white"];
        _moreImageView = imageView;
    }
    return _moreImageView;
}

- (UIButton *)topUpButton{
    if (!_topUpButton) {
        UIButton  *button = [[UIButton alloc] init];
        button.backgroundColor = ZLRedColor;
        button.layer.cornerRadius = 1;
        button.layer.masksToBounds = YES;
        [button setTitle:@"充值" forState:UIControlStateNormal];
        [button setTitleColor:ZLWhiteColor forState:UIControlStateNormal];
        button.titleLabel.font = ZLNormalFont(14);
        [button bk_whenTapped:^{
            [[ZLNavigationService sharedService]openUrl:LocalAppHost(TopUpHost)];
        }];
        _topUpButton = button;
    }
    return _topUpButton;
}

- (UILabel *)balanceLabel{
    if (!_balanceLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = ZLNormalFont(14);
        label.textColor = ZLGray(153);
        _balanceLabel = label;
    }
    return _balanceLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _topUpButton.size = CGSizeMake(66, 24);
    _topUpButton.right = self.width - 22;
    _topUpButton.top = 66;
    
    _moreImageView.size = CGSizeMake(7, 14);
    _moreImageView.right = self.width - 20;
    _moreImageView.centerY = self.height / 2;
    
    _avatarImageView.size = CGSizeMake(70, 70);
    _avatarImageView.left = 23;
    _avatarImageView.centerY = self.height / 2;
    
    _nameLabel.left = _avatarImageView.right + 17;
    _nameLabel.bottom = _avatarImageView.centerY;
    
    _balanceLabel.left = _nameLabel.left;
    _balanceLabel.top = _nameLabel.bottom + 8;
}

@end
