//
//  OptionUDView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "OptionUDView.h"

#define SELECT_COLOR    ZLRedColor
#define UNSELECT_COLOR  ZLGray(153)

#define SELECT_UP       @"priceup_select"
#define UNSELECT_UP     @"priceup_unselect"
#define SELECT_DOWN     @"pricedown_select"
#define UNSELECT_DOWN   @"pricedown_unselect"

typedef NS_ENUM(NSInteger, UDOptionStatus) {
    UDOptionStatusNone      = 1 << 0,
    UDOptionStatusUP        = 1 << 1,
    UDOptionStatusDOWN      = 1 << 2,
};

@interface OptionUDView()

@property (nonatomic, assign) UDOptionStatus optionStatus;
@property (nonatomic, strong) UIImageView *upView;
@property (nonatomic, strong) UIImageView *downView;

@end

@implementation OptionUDView

#pragma mark - override
- (void)initComponent {
    _optionStatus = UDOptionStatusNone;
    [self addSubview:self.titleLabel];
    [self addSubview:self.upView];
    [self addSubview:self.downView];
}

- (void)setIsSelect:(BOOL)isSelect {
    if (!isSelect) {
        _isSelect = NO;
        self.optionStatus = UDOptionStatusNone;
        return;
    }
    
    _isSelect = YES;
    
    if (_optionStatus & UDOptionStatusNone) {
        self.optionStatus = UDOptionStatusUP;
        return;
    }
    
    if (_optionStatus & UDOptionStatusUP) {
        self.optionStatus = UDOptionStatusDOWN;
        return;
    }
    
    if (_optionStatus & UDOptionStatusDOWN) {
        self.optionStatus = UDOptionStatusUP;
        return;
    }
}

- (void)setOptionStatus:(UDOptionStatus)optionStatus {
    _optionStatus = optionStatus;
    switch (optionStatus) {
        case UDOptionStatusNone:
            self.titleLabel.textColor = UNSELECT_COLOR;
            [self.upView setImage:[UIImage imageNamed:UNSELECT_UP]];
            [self.downView setImage:[UIImage imageNamed:UNSELECT_DOWN]];
            break;
        case UDOptionStatusDOWN:
            self.titleLabel.textColor = SELECT_COLOR;
            [self.upView setImage:[UIImage imageNamed:UNSELECT_UP]];
            [self.downView setImage:[UIImage imageNamed:SELECT_DOWN]];
            break;
        case UDOptionStatusUP:
            self.titleLabel.textColor = SELECT_COLOR;
            [self.upView setImage:[UIImage imageNamed:SELECT_UP]];
            [self.downView setImage:[UIImage imageNamed:UNSELECT_DOWN]];
            break;
        default:
            break;
    }
    
    if (self.isShowUD) {
        self.upView.hidden = NO;
        self.downView.hidden = NO;
    } else {
        self.upView.hidden = YES;
        self.downView.hidden = YES;
    }
}

- (void)setIsShowUD:(BOOL)isShowUD {
    _isShowUD = isShowUD;
    self.upView.hidden = !isShowUD;
    self.downView.hidden = !isShowUD;
}

#pragma mark - public
- (BOOL)isOrderUp {
    switch (self.optionStatus) {
        case UDOptionStatusNone:
        case UDOptionStatusUP:
            return YES;
            break;
        case UDOptionStatusDOWN:
            return NO;
            break;
        default:
            break;
    }
    return YES;
}

#pragma mark - properties
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UNSELECT_COLOR;
        _titleLabel.font = ZLNormalFont(14);
    }
    return _titleLabel;
}

- (UIImageView *)upView {
    if (!_upView) {
        _upView = [[UIImageView alloc] init];
        _upView.image =[UIImage imageNamed:UNSELECT_UP];
        [_upView sizeToFit];
    }
    return _upView;
}

- (UIImageView *)downView {
    if (!_downView) {
        _downView = [[UIImageView alloc] init];
        _downView.image = [UIImage imageNamed:UNSELECT_DOWN];
        [_downView sizeToFit];
    }
    return _downView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    _titleLabel.centerX = self.width / 2;
    _titleLabel.centerY = self.height / 2;
    
    _upView.left = self.width / 2 + _titleLabel.width / 2 + 2;
    _upView.bottom = self.height / 2;
    
    _downView.left = self.width / 2 + _titleLabel.width / 2 + 2;
    _downView.top = self.height / 2;
}

@end
