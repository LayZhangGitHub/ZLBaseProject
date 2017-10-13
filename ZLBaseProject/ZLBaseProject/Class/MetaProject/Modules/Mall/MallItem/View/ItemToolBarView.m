//
//  ItemToolBarView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemToolBarView.h"

@interface ItemToolBarView()

@property (nonatomic, strong) UIButton *chatButton;
@property (nonatomic, strong) UILabel *chatLabel;
@property (nonatomic, strong) UIImageView *chatImageView;

@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIImageView *likeImageView;

@property (nonatomic, strong) UIButton *shopButton;
@property (nonatomic, strong) UILabel *shopLabel;
@property (nonatomic, strong) UIImageView *shopImageView;

@property (nonatomic, strong) UIButton *addToCartButton;
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) UIView *vLineView1;
@property (nonatomic, strong) UIView *vLineView2;

@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation ItemToolBarView

- (void)initComponent {
    self.backgroundColor = ZLWhiteColor;
    
    [self addSubview:self.hLineView];
    
    //    [self addSubview:self.chatLabel];
    //    [self addSubview:self.chatImageView];
    //    [self addSubview:self.chatButton];
    //
    //    [self addSubview:self.vLineView1];
    
    [self addSubview:self.likeLabel];
    [self addSubview:self.likeImageView];
    [self addSubview:self.likeButton];
    
    [self addSubview:self.vLineView2];
    
    [self addSubview:self.shopLabel];
    [self addSubview:self.shopImageView];
    [self addSubview:self.shopButton];
    
    [self addSubview:self.addToCartButton];
    [self addSubview:self.buyButton];
    [self addSubview:self.statusLabel];
}

- (void)setModel:(ItemToolBarModel *)model {
    _model = model;
    
    if (model.isFav) {
        self.likeImageView.image = [UIImage imageNamed:@"icon_liked"];
    } else {
        self.likeImageView.image = [UIImage imageNamed:@"icon_like"];
    }
    
    if ( [model.status isEqualToString:StatusOnSell]) {
        self.buyButton.enabled = YES;
        self.addToCartButton.enabled = YES;
        self.addToCartButton.alpha = 1;
        self.buyButton.alpha = 1;
        self.statusLabel.hidden = YES;
    } else {
        self.buyButton.enabled = NO;
        self.addToCartButton.enabled = NO;
        self.addToCartButton.alpha = 0.38;
        self.buyButton.alpha = 0.38;
        
        if ( [StatusSellOut isEqualToString:model.status] ) {
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"已售罄";
        } else if ( [StatusUnderCarriage isEqualToString:model.status] ) {
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"已下架";
        }
    }
}

#pragma mark - properties
- (UIView *)hLineView {
    if (!_hLineView) {
        _hLineView = [[UIView alloc] init];
        _hLineView.backgroundColor = ZLGray(224);
    }
    return _hLineView;
}

- (UIButton *)chatButton {
    if (!_chatButton) {
        _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chatButton.frame = CGRectMake(0, 0, 52, 45);
        [_chatButton addTarget:self action:@selector(handleChatButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatButton;
}

- (UILabel *)chatLabel {
    if (!_chatLabel) {
        _chatLabel = [[UILabel alloc] init];
        _chatLabel.textColor = ZLGray(130);
        _chatLabel.font = ZLNormalFont(10);
        _chatLabel.text = @"客服";
        [_chatLabel sizeToFit];
    }
    return _chatLabel;
}

- (UIImageView *)chatImageView {
    if (!_chatImageView) {
        _chatImageView = [[UIImageView alloc] init];
        _chatImageView.image = [UIImage imageNamed:@"icon_support"];
    }
    return _chatImageView;
}

- (UIView *)vLineView1 {
    if (!_vLineView1) {
        _vLineView1 = [[UIView alloc] init];
        _vLineView1.backgroundColor = ZLGray(224);
    }
    return _vLineView1;
}

- (UIButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame = CGRectMake(0, 0, 77, 45);
        [_likeButton addTarget:self action:@selector(handleLikeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}

- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.textColor = ZLGray(130);
        _likeLabel.font = ZLNormalFont(10);
        _likeLabel.text = @"收藏";
        [_likeLabel sizeToFit];
    }
    return _likeLabel;
}

- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.image = [UIImage imageNamed:@"icon_like"];
    }
    return _likeImageView;
}

- (UIView *)vLineView2 {
    if (!_vLineView2) {
        _vLineView2 = [[UIView alloc] init];
        _vLineView2.backgroundColor = ZLGray(224);
    }
    return _vLineView2;
}

- (UIButton *)shopButton {
    if (!_shopButton) {
        _shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopButton.frame = CGRectMake(79, 0, 78, 45);
        [_shopButton addTarget:self action:@selector(handleShopButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopButton;
}

- (UILabel *)shopLabel {
    if (!_shopLabel) {
        _shopLabel = [[UILabel alloc] init];
        _shopLabel.textColor = ZLGray(130);
        _shopLabel.font = ZLNormalFont(10);
        _shopLabel.text = @"店铺";
        [_shopLabel sizeToFit];
    }
    return _shopLabel;
}

- (UIImageView *)shopImageView {
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc] init];
        _shopImageView.image = [UIImage imageNamed:@"icon_shop"];
    }
    return _shopImageView;
}

- (UIButton *)addToCartButton {
    if (!_addToCartButton) {
        _addToCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addToCartButton.titleLabel.font = ZLNormalFont(16);
        [_addToCartButton addTarget:self action:@selector(handleAddToCartButton) forControlEvents:UIControlEventTouchUpInside];
        [_addToCartButton setTitleColor:ZLGray(255) forState:UIControlStateNormal];
        [_addToCartButton setTitleColor:ZLGray(255) forState:UIControlStateDisabled];
        [_addToCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addToCartButton setBackgroundColor:ZLGray(85)];
        _addToCartButton.layer.cornerRadius = 2.;
        _addToCartButton.layer.masksToBounds = YES;
    }
    
    return _addToCartButton;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.titleLabel.font = ZLNormalFont(16);
        [_buyButton addTarget:self action:@selector(handleBuyButton) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton setTitleColor:ZLWhiteColor forState:UIControlStateNormal];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton setBackgroundColor:ZLRedColor];
        _buyButton.layer.cornerRadius = 2.;
        _buyButton.layer.masksToBounds = YES;
    }
    return _buyButton;
}

- (UILabel*)statusLabel {
    if (!_statusLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = ZLNormalFont(16);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = ZLWhiteColor;
        label.backgroundColor = ZLRGBA(0, 0, 0, 0.8);
        label.hidden = YES;
        _statusLabel = label;
    }
    return _statusLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _hLineView.frame = CGRectMake(0, 0, SCREENWIDTH, LINEWIDTH);
    
//chat
//    _chatButton.frame = CGRectMake(0, 0, 52, 45);
//    _chatLabel.frame
//    _chatImageView.frame = CGRectMake(0, 0, 16, 15);
//    _vLineView1.frame = CGRectMake(52, 0, LINEWIDTH, self.height)

    //like
    _likeButton.frame = CGRectMake(0, 0, 77, 45);
    _likeImageView.size = CGSizeMake(16, 15);
    _likeImageView.top = 8;
    _likeImageView.centerX = _likeButton.centerX;
    [_likeLabel sizeToFit];
    _likeLabel.top = _likeImageView.bottom + 2;
    _likeLabel.centerX = _likeButton.centerX;
    _vLineView2.frame = CGRectMake(78, 0, LINEWIDTH, self.height);
    
    // shop
    _shopButton.frame = CGRectMake(79, 0, 77, 45);
    _shopImageView.size = CGSizeMake(16, 15);
    _shopImageView.top = 8;
    _shopImageView.centerX = _shopButton.centerX;
    [_shopLabel sizeToFit];
    _shopLabel.top = _shopImageView.bottom + 2;
    _shopLabel.centerX = _shopButton.centerX;
    
    // cart
    CGFloat buttonWidth = (self.width - _shopButton.right - 2 * 10) / 2;
    _addToCartButton.size = CGSizeMake(buttonWidth, 32);
    _addToCartButton.left = _shopButton.right;
    _addToCartButton.centerY = self.height / 2;
    // buy
    _buyButton.size = CGSizeMake(buttonWidth, 32);
    _buyButton.left = _addToCartButton.right + 10;
    _buyButton.centerY = self.height / 2;
    
    // status
    _statusLabel.frame = CGRectMake(0, -44, self.width, 44);
}


#pragma mark - Event Response

- (void)handleChatButton {
    if ([self.delegate respondsToSelector:@selector(chatButtonDidClick)]) {
        [self.delegate chatButtonDidClick];
    }
}

- (void) handleLikeButton {
    if ([self.delegate respondsToSelector:@selector(myCollectionButtonDidClick)]) {
        [self.delegate myCollectionButtonDidClick];
    }
}

- (void) handleShopButton {
    if ([self.delegate respondsToSelector:@selector(shopButtonDidClick)]) {
        [self.delegate shopButtonDidClick];
    }
}

- (void) handleAddToCartButton {
    if ([self.delegate respondsToSelector:@selector(addToCartButtonDidClick)]) {
        [self.delegate addToCartButtonDidClick];
    }
}

- (void) handleBuyButton {
    if ([self.delegate respondsToSelector:@selector(buyButtonDidClick)]) {
        [self.delegate buyButtonDidClick];
    }
}

@end

@implementation ItemToolBarModel

- (instancetype)initWithIsFav:(BOOL)isFav status:(NSString *)status {
    if (self = [super init]) {
        self.isFav = isFav;
        self.status = status;
    }
    return self;
}

@end

