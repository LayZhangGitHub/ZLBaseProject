//
//  ThirdPartLoginView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ThirdPartLoginView.h"
#import "WXApi.h"

#define BUTTON_WIDTH (SCREENWIDTH / 7)

@interface ThirdPartLoginView()
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *rightLine;

@property (nonatomic, strong) UIButton *weiboButton;
@property (nonatomic, strong) UIButton *wechatButton;
@property (nonatomic, strong) UIButton *qqButton;

@end

@implementation ThirdPartLoginView

- (void)initComponent {
    [self addSubview:self.leftLine];
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightLine];
    
    [self addSubview:self.weiboButton];
    [self addSubview:self.wechatButton];
    [self addSubview:self.qqButton];
}

#pragma mark -Subviews

- (UIView *)leftLine {
    if (!_leftLine) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 0, 80, LINEWIDTH)];
        view.backgroundColor =  ZLGray(125);
        view.centerY = self.titleLabel.centerY;
        view.centerX = SCREENWIDTH / 6;
        _leftLine = view;
    }
    return _leftLine;
}

- (UILabel*)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, 0, 0)];
        label.font = ZLNormalFont(14);
        label.textColor = ZLGray(125);
        label.text = @"第三方快捷登录";
        [label sizeToFit];
        label.centerX = SCREENWIDTH / 2;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, LINEWIDTH)];
        view.backgroundColor =  ZLGray(125);
        view.centerY = self.titleLabel.centerY;
        view.centerX = SCREENWIDTH * 5 / 6;
        _rightLine = view;
    }
    return _rightLine;
}

- (UIButton *)weiboButton {
    if (!_weiboButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"login_weibo"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(weiboButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _weiboButton = button;
    }
    return _weiboButton;
}

- (UIButton*)wechatButton {
    if (!_wechatButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(wechatButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _wechatButton = button;
    }
    return _wechatButton;
}

- (UIButton *)qqButton {
    if (!_qqButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(qqButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _qqButton = button;
    }
    return _qqButton;
}

#pragma mark - Button Actions
- (void)weiboButtonTapped {
    if (_delegate && [_delegate respondsToSelector:@selector(weiboAuthorizeLogin)]) {
        [self.delegate weiboAuthorizeLogin];
    }
}

- (void)wechatButtonTapped {
    if (_delegate && [_delegate respondsToSelector:@selector(wechatAuthorizeLogin)]) {
        [self.delegate wechatAuthorizeLogin];
    }
}

- (void)qqButtonTapped {
    if (_delegate && [_delegate respondsToSelector:@selector(tencentAuthorizeLogin)]) {
        [self.delegate tencentAuthorizeLogin];
    }
}

+ (BOOL)requiresConstraintBasedLayout {
    return NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _qqButton.size = CGSizeMake(BUTTON_WIDTH, BUTTON_WIDTH);
    _weiboButton.size = CGSizeMake(BUTTON_WIDTH, BUTTON_WIDTH);
    _wechatButton.size = CGSizeMake(BUTTON_WIDTH, BUTTON_WIDTH);
    
    _weiboButton.centerX = _leftLine.centerX;
    _weiboButton.bottom = self.height - 30;
    _qqButton.centerX = _rightLine.centerX;
    _qqButton.bottom = _weiboButton.bottom;
    _wechatButton.centerX = self.width / 2;
    _wechatButton.bottom = _weiboButton.bottom;
    
    if ([WXApi isWXAppInstalled]) {
        _wechatButton.hidden = NO;
        
        _qqButton.centerX = SCREENWIDTH / 6.f;
        _wechatButton.centerX = SCREENWIDTH / 2.f;
        _weiboButton.centerX = SCREENWIDTH * 5 / 6.f;
    } else {
        _wechatButton.hidden = YES;
        
        _qqButton.centerX = SCREENWIDTH / 4.f;
        _weiboButton.centerX = SCREENWIDTH * 3 / 4.f;
    }
}

@end
