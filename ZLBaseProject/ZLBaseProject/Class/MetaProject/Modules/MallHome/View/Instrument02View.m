//
//  Instrument02View.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/28.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "Instrument02View.h"

@interface Instrument02View()


@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation Instrument02View
#pragma mark - override
- (void)initComponent {
    [self addSubview:self.iconImageView];
    [self bk_whenTapped:^{
        [[ZLNavigationService sharedService] openUrl:_model[@"link"]];
    }];
}

- (void)setModel:(NSDictionary *)model {
    _model = model;
    if (_model) {
        self.iconImageView.hidden = NO;
        [self.iconImageView setOnlineImage:_model[@"icon"] placeHolderImage:[UIImage imageNamed:_model[@"placeholder"]]];
    }else{
        self.iconImageView.hidden = YES;
    }
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.layer.cornerRadius = 2.;
        imageView.layer.masksToBounds = YES;
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (void)updateConstraints {
    [super updateConstraints];
    [_iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}


@end
