//
//  TMCateModuleView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMCateModuleView.h"

@interface TMCateModuleView()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TMCateModuleView
#pragma mark - override
- (void)initComponent {
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    weakSelf(self);
    [self bk_whenTapped:^{
        strongSelf(self);
        [[ZLNavigationService sharedService] openUrl:self.model.link];
    }];
}

- (void)setModel:(TMCateModuleModel *)model {
    _model = model;
    if (_model) {
        self.iconImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        
        [self.iconImageView setOnlineImage:_model.imageSrc placeHolderImage:[UIImage imageNamed:@"placeholder_h"]];
        self.titleLabel.text = _model.name;
    }else{
        self.iconImageView.hidden = YES;
        self.titleLabel.hidden = YES;
    }
}

#pragma mark - properties
- (UIImageView*)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel*)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = ZLNormalFont(14);
        label.textColor = ZLGray(45);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _iconImageView.size = CGSizeMake(66, 85);
    _iconImageView.centerX = self.width / 2;
    
    [_titleLabel sizeToFit];
    _titleLabel.top = _iconImageView.bottom + 6;
    _titleLabel.centerX = _iconImageView.centerX;
}

@end
