//
//  ShopItemCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopItemCell.h"

#define EDGE 15.f
#define CELL_WIDTH ((SCREENWIDTH - EDGE) / 2)

@interface ShopItemCell() <CAAnimationDelegate>

@end

@implementation ShopItemCell

- (void)prepareForReuse {
    [super prepareForReuse];
    [self hideMaskAnimated];
}

#pragma mark - override
- (void)reloadData {}


+ (NSNumber *)heightForCell:(id)cellData { return 0; }

#pragma mark - properties

- (UIImageView *)itemImageView {
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CELL_WIDTH, 0)];
    }
    return _itemImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.textColor = ZLGray(100);
        _titleLabel.font = ZLNormalFont(12);
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _priceLabel.textColor = ZLRedColor;
        _priceLabel.font = ZLBoldFont(14);
    }
    return _priceLabel;
}

- (UIButton*)moreButton {
    if (!_moreButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button setTitle:@"..." forState:UIControlStateNormal];
        button.titleLabel.font = ZLNormalFont(20);
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [button setTitleColor:ZLGray(216) forState:UIControlStateNormal];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [button addTarget:self action:@selector(handleMoreButton) forControlEvents:UIControlEventTouchUpInside];
        _moreButton = button;
    }
    return _moreButton;
}

- (UIButton*)favButton {
    if (!_favButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        [button setTitle:@"收藏" forState:UIControlStateNormal];
        [button setTitle:@"已收藏" forState:UIControlStateSelected];
        [button setTitleColor:ZLGray(45) forState:UIControlStateNormal];
        [button setTitleColor:ZLRGB(240, 181, 2) forState:UIControlStateSelected];
        button.backgroundColor = ZLWhiteColor;
        button.layer.cornerRadius = 30.;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = ZLNormalFont(16);
        button.alpha = 0;
        [button addTarget:self action:@selector(handleFavButton) forControlEvents:UIControlEventTouchUpInside];
        _favButton = button;
    }
    return _favButton;
}

- (CAShapeLayer*)roundLayer {
    if (!_roundLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 40, 40) cornerRadius:20];
        layer.path = path.CGPath;
        layer.fillColor = ZLRGBA(0, 0, 0, 0.4).CGColor;
        layer.bounds = CGPathGetBoundingBox(layer.path);
        layer.hidden = YES;
        _roundLayer = layer;
    }
    return _roundLayer;
}

#pragma mark - event handle
- (void)handleMoreButton {
    if ([self.delegate respondsToSelector:@selector(cell:tapMoreButton:)]) {
        [self.delegate cell:self tapMoreButton:self.cellData];
    }
    [self showMaskAnimated];
}

- (void)handleFavButton {
    if ([self.delegate respondsToSelector:@selector(cell:tapFavButton:)]) {
        [self.delegate cell:self tapFavButton:self.cellData];
    }
}

#pragma mark - animation
- (void)showMaskAnimated {
    if (!self.showMask) {
        [self.contentView.layer addSublayer:self.roundLayer];
        self.roundLayer.position = CGPointMake( self.width/2,  self.height/2);
        
        self.roundLayer.hidden = NO;
        self.moreButton.userInteractionEnabled = NO;
        
        CABasicAnimation *animation = (CABasicAnimation *)[self.layer animationForKey:@"transform"];
        
        if (animation) {
            [self resume];
        }else{
            [self animteMask];
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            self.favButton.alpha = 1;
        }];
    }
}

- (void)hideMaskAnimated {
    if (self.showMask) {
        self.roundLayer.hidden = YES;
        self.favButton.alpha = 0;
        self.showMask = NO;
        self.moreButton.userInteractionEnabled = YES;
    }
}

- (void)animteMask {
    self.layer.masksToBounds = YES;
    
    //创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    //
    [animation setDuration:0.4];
    
    //NO可以防止退到后台动画停止，这里不需要
    animation.removedOnCompletion = NO;
    //放大倍数
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(20., 20., 1.)];
    
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.delegate = self;
    
    //沿中心放大
    self.roundLayer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.roundLayer addAnimation:animation forKey:@"transform"];
}

- (void)pause {
    self.roundLayer.speed = 0.0;
}

- (void)resume {
    self.roundLayer.speed = 1.0;
}

#pragma mark - animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        self.showMask = YES;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.moreButton];
    self.moreButton.right = self.width - 5;
    self.moreButton.bottom = self.height - 5;
    
    [self cellAddSubview:self.favButton];
    self.favButton.centerX = self.width/2;
    self.favButton.centerY = self.height/2;
}

@end
