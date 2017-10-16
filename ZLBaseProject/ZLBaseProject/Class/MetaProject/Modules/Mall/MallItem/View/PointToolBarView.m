//
//  PointToolBarView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PointToolBarView.h"

@interface PointToolBarView()

@property (nonatomic, strong) UIButton *creditsExchangeButton;

@end

@implementation PointToolBarView

#pragma mark - override
- (void)initComponent {
    self.backgroundColor = ZLWhiteColor;
    [self addSubview:self.creditsExchangeButton];
}

#pragma mark - properties
- (UIButton *)creditsExchangeButton {
    if (!_creditsExchangeButton) {
        _creditsExchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _creditsExchangeButton.titleLabel.font = ZLNormalFont(14);
        [_creditsExchangeButton addTarget:self action:@selector(handleCreditsExchangeButton) forControlEvents:UIControlEventTouchUpInside];
        [_creditsExchangeButton setTitleColor:ZLWhiteColor forState:UIControlStateNormal];
        [_creditsExchangeButton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_creditsExchangeButton setBackgroundColor:ZLRedColor];
        _creditsExchangeButton.layer.borderColor = ZLRedColor.CGColor;
        _creditsExchangeButton.layer.borderWidth = 1.0f;
    }
    return _creditsExchangeButton;
}

- (void)handleCreditsExchangeButton {
    if ([self.delegate respondsToSelector:@selector(buyButtonDidClick)]) {
        [self.delegate buyButtonDidClick];
    }
}

- (void)updateConstraints {
    [super updateConstraints];
    [_creditsExchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).offset(-40 * 2);
        make.height.equalTo(@32);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
