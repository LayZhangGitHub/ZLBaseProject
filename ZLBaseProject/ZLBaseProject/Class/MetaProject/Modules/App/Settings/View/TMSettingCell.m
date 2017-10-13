//
//  TMSettingCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMSettingCell.h"

@interface TMSettingCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation TMSettingCell

- (void)initCellComponent {
    self.backgroundColor = ZLWhiteColor;
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.moreImageView];
}

- (void)reloadData {
    if (self.cellData) {
        NSDictionary *itemData = (NSDictionary *)self.cellData;
        
        if ([itemData[@"arrow"] boolValue]) {
            self.moreImageView.hidden = NO;
        } else {
            self.moreImageView.hidden = YES;
        }
        
        if ([@"avatar" isEqualToString:itemData[@"type"]]) {
            self.avatarImageView.hidden = NO;
            self.valueLabel.hidden = YES;
            if ([[UserInfoService shareUserInfo].userInfo.avatar isNotEmptyString]) {
                [self.avatarImageView setOnlineImage:[UserInfoService shareUserInfo].userInfo.avatar
                                    placeHolderImage:[UIImage imageNamed:@"mine_default_avatar"]];
            }else{
                self.avatarImageView.image = [UIImage imageNamed:@"mine_default_avatar"];
            }
        } else {
            self.avatarImageView.hidden = YES;
            self.valueLabel.hidden = NO;
            
            NSString *value = @"";
            
            if ([@"name" isEqualToString:itemData[@"type"]]) {
                value = [UserInfoService shareUserInfo].userInfo.name;
            } else if ([@"phone" isEqualToString:itemData[@"type"]]) {
                value = [UserInfoService shareUserInfo].userInfo.phone;
            } else if ([@"gender" isEqualToString:itemData[@"type"]]) {
                if ([@"1" isEqualToString:[UserInfoService shareUserInfo].userInfo.gender]) {
                    value = @"男";
                } else {
                    value = @"女";
                }
            }
            
            self.valueLabel.text = value;
            
            [self.valueLabel sizeToFit];
            
            if ([itemData[@"arrow"] boolValue]) {
                self.valueLabel.right = SCREENWIDTH - 40;
            } else {
                self.valueLabel.right = SCREENWIDTH - 20;
            }
        }
        
        self.titleLabel.text = itemData[@"title"];
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 20;

        self.lineView.hidden = ![itemData[@"line"] boolValue];
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        NSDictionary *itemData = (NSDictionary *)cellData;
        if ([@"empty" isEqualToString:itemData[@"type"]]) {
            height = 20;
        } else if ([@"avatar" isEqualToString:itemData[@"type"]]) {
            height = 120;
        }  else {
            height = 50;
        }
    }
    return @(height);
}

#pragma mark - Getters And Setters
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 35;
    }
    
    return _avatarImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = ZLGray(42);
        _titleLabel.font = ZLNormalFont(16);
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textColor = ZLGray(148);
        _valueLabel.font = ZLNormalFont(16);
    }
    return _valueLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ZLGray(230);
    }
    return _lineView;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
    }
    return _moreImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _moreImageView.size = CGSizeMake(7, 13);
    _moreImageView.centerY = self.height / 2;
    _moreImageView.right = self.width - 15;
    
    _lineView.frame = CGRectMake(15, 0, self.width - 15 * 2, LINEWIDTH);
    _lineView.bottom = self.height;
    
    _avatarImageView.size = CGSizeMake(70, 70);
    _avatarImageView.centerY = 60;
    _avatarImageView.right = self.width - 20 * 2;
    
    _titleLabel.centerY = self.height / 2;
    
    _valueLabel.centerY = self.height / 2;

}

@end
