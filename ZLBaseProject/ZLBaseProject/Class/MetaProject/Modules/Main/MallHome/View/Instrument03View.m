//
//  Instrument03View.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/29.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "Instrument03View.h"

#define DefaultFont ZLNormalFont(14)
#define DefaultTextAlignment NSTextAlignmentCenter

@interface Instrument03View()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end


@implementation Instrument03View

#pragma mark - override
- (void)initComponent {
    self.textAlignment = DefaultTextAlignment;
    self.font = DefaultFont;
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    
    [self bk_whenTapped:^{
        [[ZLNavigationService sharedService] openUrl:_model[@"link"]];
    }];
}

- (void)setModel:(NSDictionary *)model {
    _model = model;
    if (_model) {
        self.iconImageView.hidden = NO;
        
        [self.iconImageView setOnlineImage: _model[@"icon"] placeHolderImage:[UIImage imageNamed:_model[@"placeholder"]]];
        
        self.titleLabel.font = self.font;
        self.descLabel.font = self.font;
        
        if (_model[@"title"]) {
            self.titleLabel.hidden = NO;
            self.titleLabel.text = _model[@"title"];
        } else {
            self.titleLabel.hidden = YES;
            self.descLabel.top = self.iconImageView.bottom + 6;
        }
        
        if (_model[@"desc"]) {
            self.descLabel.hidden = NO;
            self.descLabel.text = _model[@"desc"];
        } else {
            self.descLabel.hidden = YES;
        }
    } else {
        self.iconImageView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.descLabel.hidden = YES;
    }
}

#pragma mark - properties
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel*)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = self.font;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = self.font;
        label.textColor = ZLGray(42);
        _descLabel = label;
    }
    return _descLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_model) {
        _iconImageView.width = [_model[@"iconWidth"] floatValue];
        _iconImageView.height = [_model[@"iconHeight"] floatValue];
        _iconImageView.centerX = self.width / 2;
        if (_model[@"title"]) {
            [self.titleLabel sizeToFit];
            self.titleLabel.top = _iconImageView.bottom + 6;
            if (self.textAlignment == NSTextAlignmentCenter) {
                _titleLabel.centerX = _iconImageView.centerX;
            }else if (self.textAlignment == NSTextAlignmentLeft) {
                _titleLabel.left = 0;
            }else if (self.textAlignment == NSTextAlignmentRight) {
                _titleLabel.right = self.right;
            }
            _descLabel.top = self.titleLabel.bottom + 4;
        } else {
            _descLabel.top = self.iconImageView.bottom + 6;
        }

        if (_model[@"desc"]) {
            [self.descLabel sizeToFit];
            if (self.textAlignment == NSTextAlignmentCenter) {
                _descLabel.centerX = _iconImageView.centerX;
            }else if (self.textAlignment == NSTextAlignmentLeft) {
                _descLabel.left = 0;
            }else if (self.textAlignment == NSTextAlignmentRight) {
                _descLabel.right = self.right;
            }
        }
    }
}

+ (BOOL)requiresConstraintBasedLayout {
    return NO;
}


@end
