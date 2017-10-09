//
//  PMInstrumentView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PMInstrumentView.h"

@interface PMInstrumentView()

@property (nonatomic, strong) UIView *bkgView;

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *priceLable;

@end

@implementation PMInstrumentView

- (void)initComponent {
    [self addSubview:self.bkgView];
    [self.bkgView addSubview:self.itemImageView];
    [self.bkgView addSubview:self.titleLable];
    [self.bkgView addSubview:self.priceLable];

    self.userInteractionEnabled = YES;
    weakSelf(self);
    [self bk_whenTapped:^{
        strongSelf(self);
        [self handleTap];
    }];
}

- (void)setPmItemModel:(PMItemModel *)pmItemModel {
    _pmItemModel = pmItemModel;
    if (pmItemModel) {
        self.itemImageView.hidden = NO;
        self.titleLable.hidden = NO;
        self.priceLable.hidden = NO;
        
        [self.itemImageView setOnlineImage:pmItemModel.image placeHolderImage:[UIImage imageNamed:@"placeholder_h"]];
        
        self.titleLable.text = pmItemModel.title;
        self.priceLable.text = pmItemModel.desc;
    }else {
        self.bkgView.backgroundColor = [UIColor clearColor];
        
        self.itemImageView.image = nil;
        self.itemImageView.hidden = YES;
        
        self.titleLable.text = @"";
        self.titleLable.hidden = YES;
        
        self.priceLable.text = @"";
        self.titleLable.hidden = YES;
    }
}

#pragma mark - properties
- (UIView* )bkgView {
    if (!_bkgView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZLWhiteColor;
        view.layer.cornerRadius = 3;
        view.layer.masksToBounds = YES;
        _bkgView = view;
    }
    return _bkgView;
}

- (UIImageView *)itemImageView {
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] init];
    }
    return _itemImageView;
}

- (UILabel *)titleLable {
    if ( !_titleLable ) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = ZLGray(100);
        _titleLable.font = ZLNormalFont(12);
    }
    return _titleLable;
}

- (UILabel *)priceLable {
    if ( !_priceLable ) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.textColor = ZLRedColor;
        _priceLable.font = ZLBoldFont(14);
    }
    return _priceLable;
}


- (void)handleTap {
    if (self.pmItemModel) {
        [[ZLNavigationService sharedService] openUrl:self.pmItemModel.link];
    }
}

- (void)updateConstraints {
    [super updateConstraints];

    CGFloat bkgViewHeight = 0;
    CGFloat itemImageViewHeight = 0;
    if (_pmItemModel) {
        bkgViewHeight = self.width / _pmItemModel.ar + 50;
        itemImageViewHeight = self.width / _pmItemModel.ar;
    }
    
    [_bkgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.equalTo(@(bkgViewHeight));
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    
    [_itemImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.bkgView).offset(- 2 * 4);
        make.height.equalTo(@(itemImageViewHeight));
        make.left.equalTo(self.bkgView).offset(4);
        make.top.equalTo(self.bkgView);
    }];
    
    [_titleLable mas_updateConstraints:^(MASConstraintMaker *make) {
        [_titleLable sizeToFit];
        make.width.equalTo(self.bkgView);
        make.left.equalTo(self.itemImageView.mas_left).offset(5);
        make.top.equalTo(self.itemImageView.mas_bottom).offset(4);
    }];
    
    [_priceLable mas_updateConstraints:^(MASConstraintMaker *make) {
        [_titleLable sizeToFit];
        make.width.equalTo(self.bkgView);
        make.left.equalTo(self.itemImageView.mas_left).offset(5);
        make.top.equalTo(self.titleLable.mas_bottom).offset(5);
    }];
}



@end
