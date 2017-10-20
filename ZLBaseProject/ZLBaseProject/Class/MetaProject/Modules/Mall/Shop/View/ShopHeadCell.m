//
//  ShopHeadCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopHeadCell.h"
#import "ShopInfoModel.h"
#import "ItemMarkView.h"

@interface ShopHeadCell()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *shopNameLable;
@property (nonatomic, strong) ItemMarkView *markView;
@property (nonatomic, strong) UILabel *countLable;
@property (nonatomic, strong) UIButton *addFavButton;
@property (nonatomic, strong) UIButton *cancelFavButton;

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ShopHeadCell

#pragma mark - override

- (void)reloadData {
    //    self.backgroundColor = Color_Red4;
    
    if (self.cellData) {
        
        ShopInfoModel *shopInfo = (ShopInfoModel *)self.cellData;
        
        [self cellAddSubview:self.bgImageView];
        [self cellAddSubview:self.logoImageView];
        [self cellAddSubview:self.shopNameLable];
        [self cellAddSubview:self.markView];
        [self cellAddSubview:self.countLable];
        [self cellAddSubview:self.addFavButton];
        [self cellAddSubview:self.cancelFavButton];
        
        [self.bgImageView setOnlineImage:shopInfo.cover];
        self.bgImageView.height = SCREENWIDTH / shopInfo.ar;
        
        [self.logoImageView setOnlineImage:shopInfo.logo];
        self.logoImageView.left = 15;
        self.logoImageView.bottom = [[[self class] heightForCell:self.cellData] floatValue] - 15;
        
        self.shopNameLable.text = shopInfo.shopName;
        [self.shopNameLable sizeToFit];
        self.shopNameLable.top = self.logoImageView.top;
        self.shopNameLable.left = self.logoImageView.right + 7;
        
        self.markView.mark = [shopInfo.score floatValue];
        self.markView.left = self.shopNameLable.left;
        self.markView.top = self.shopNameLable.bottom + 2;
        
        self.countLable.text = [NSString stringWithFormat:@"销量%@ | 收藏%@", shopInfo.sales, shopInfo.favCount];
        [self.countLable sizeToFit];
        self.countLable.top = self.markView.bottom + 2;
        self.countLable.left = self.shopNameLable.left;
        
        self.addFavButton.centerY = self.countLable.centerY;
        self.cancelFavButton.centerY = self.countLable.centerY;
        self.addFavButton.hidden = YES;
        self.cancelFavButton.hidden = YES;
        if (shopInfo.isFav) {
            self.cancelFavButton.hidden = NO;
        } else {
            self.addFavButton.hidden = NO;
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        ShopInfoModel *shopInfo = (ShopInfoModel*)cellData;
        height = SCREENWIDTH / shopInfo.ar;
    }
    return @(height);
}

#pragma mark - properties
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 5, 60, 60)];
        _logoImageView.layer.borderWidth = 1.;
        _logoImageView.layer.borderColor = ZLWhiteColor.CGColor;
    }
    return _logoImageView;
}

- (UILabel *)shopNameLable {
    if (!_shopNameLable) {
        _shopNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shopNameLable.textColor = ZLWhiteColor;
        _shopNameLable.font = ZLNormalFont(16);
    }
    return _shopNameLable;
}

- (ItemMarkView *)markView {
    if (!_markView) {
        ItemMarkView *markView = [[ItemMarkView alloc] init];
        markView.markWidth = 12;
        markView.showMark = YES;
        markView.userInteractionEnabled = NO;
        [markView sizeToFit];
        _markView = markView;
    }
    return _markView;
}

- (UILabel *)countLable {
    if (!_countLable) {
        _countLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _countLable.textColor = ZLWhiteColor;
        _countLable.font = ZLNormalFont(12);
    }
    return _countLable;
}

- (UIButton *)addFavButton {
    if (!_addFavButton) {
        _addFavButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addFavButton.frame = CGRectMake(0, 0, 62, 25);
        [_addFavButton setTitle:@"收藏" forState:UIControlStateNormal];
        [_addFavButton setTitleColor:ZLWhiteColor forState:UIControlStateNormal];
        _addFavButton.titleLabel.font = ZLNormalFont(12);
        _addFavButton.layer.masksToBounds = YES;
        _addFavButton.layer.cornerRadius = 12.5f;
        _addFavButton.layer.borderColor = ZLWhiteColor.CGColor;
        _addFavButton.layer.borderWidth = 1.0f;
        [_addFavButton addTarget:self action:@selector(handleAddFavButton:) forControlEvents:UIControlEventTouchUpInside];
        _addFavButton.top = 32;
        _addFavButton.right = SCREENWIDTH - 13;
    }
    return _addFavButton;
}

- (UIButton *)cancelFavButton {
    if (!_cancelFavButton) {
        _cancelFavButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelFavButton.frame = CGRectMake(0, 0, 62, 25);
        [_cancelFavButton setTitle:@"已收藏" forState:UIControlStateNormal];
        [_cancelFavButton setTitleColor:ZLWhiteColor forState:UIControlStateNormal];
        _cancelFavButton.titleLabel.font = ZLNormalFont(12);
        _cancelFavButton.layer.masksToBounds = YES;
        _cancelFavButton.layer.cornerRadius = 12.5f;
        _cancelFavButton.layer.borderColor = ZLRedColor.CGColor;
        _cancelFavButton.layer.borderWidth = 1.0f;
        _cancelFavButton.backgroundColor = ZLRedColor;
        [_cancelFavButton addTarget:self action:@selector(handleCancelFavButton:) forControlEvents:UIControlEventTouchUpInside];
        _cancelFavButton.top = 32;
        _cancelFavButton.right = SCREENWIDTH - 13;
    }
    return _cancelFavButton;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, SCREENWIDTH, LINEWIDTH)];
        _topLineView.backgroundColor = ZLGray(230);
    }
    return _topLineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, [[ShopHeadCell heightForCell:nil] floatValue] - LINEWIDTH, SCREENWIDTH, LINEWIDTH)];
        _bottomLineView.backgroundColor = ZLGray(230);
    }
    return _bottomLineView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 70, SCREENWIDTH, 45)];
        _searchBar.placeholder = @"搜索本店铺的商品";
        _searchBar.barTintColor = ZLGray(230);
//        _searchBar.delegate = self;
    }
    return _searchBar;
}

#pragma mark - event handle
- (void)handleCancelFavButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cancelFavShop:)]) {
        [self.delegate cancelFavShop:sender];
    }
}

- (void)handleAddFavButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(addFavShop:)]) {
        [self.delegate addFavShop:sender];
    }
}

@end
