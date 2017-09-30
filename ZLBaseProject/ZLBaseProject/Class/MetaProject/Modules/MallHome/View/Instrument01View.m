//
//  Instrument01View.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/28.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "Instrument01View.h"

@interface Instrument01View ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation Instrument01View

- (void)initComponent {
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self bk_whenTapped:^{
        [[ZLNavigationService sharedService] openUrl:_model[@"link"]];
    }];
}

- (void)setModel:(NSDictionary*)model {
    _model = model;
    if (_model) {
        self.iconImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        
        [self.iconImageView setOnlineImage:_model[@"icon"] placeHolderImage:[UIImage imageNamed:@"placeholder_s"]];
        self.titleLabel.text = _model[@"title"];
    }else{
        self.iconImageView.hidden = YES;
        self.titleLabel.hidden = YES;
    }
}

- (UIImageView*)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel*)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = ZLNormalFont(14);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)updateConstraints {
    [super updateConstraints];
    CGFloat ar = 1.0f;
    if (_model[@"ar"]) {
        ar = [_model[@"ar"] floatValue];
    }
    [_iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(35));
        make.height.equalTo(@(35 / ar));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(8));
    }];
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        [_titleLabel sizeToFit];
        make.centerX.equalTo(_iconImageView.mas_centerX);
        make.top.equalTo(_iconImageView.mas_bottom).offset(6);
    }];
}

@end
