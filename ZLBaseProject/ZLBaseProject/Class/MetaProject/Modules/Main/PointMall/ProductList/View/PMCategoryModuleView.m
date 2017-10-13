//
//  PMCategoryModuleView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PMCategoryModuleView.h"

@interface PMCategoryModuleView()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation PMCategoryModuleView

- (void)initComponent {
    [self addSubview:self.iconImageView];
    
    weakSelf(self);
    [self bk_whenTapped:^{
        strongSelf(self);
        [[ZLNavigationService sharedService] openUrl:self.pmCatesModel.link];
    }];
}

#pragma mark - setData
- (void)setPmCatesModel:(PMCatesModel *)pmCatesModel {
    _pmCatesModel = pmCatesModel;
    if (_pmCatesModel) {
        self.iconImageView.hidden = NO;
        [self.iconImageView setOnlineImage:_pmCatesModel.image
                          placeHolderImage:[UIImage imageNamed:@"placeholder_s"]];
    }else{
        self.iconImageView.hidden = YES;
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

- (void)updateConstraints {
    [super updateConstraints];
    
    [_iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
}

@end
