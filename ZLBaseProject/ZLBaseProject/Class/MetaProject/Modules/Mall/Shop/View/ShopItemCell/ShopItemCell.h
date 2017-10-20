//
//  ShopItemCell.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseCollectionCell.h"

@protocol ShopItemCellDelegate;

@interface ShopItemCell : BaseCollectionCell

@property (nonatomic, weak) id<ShopItemCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIButton *favButton;
@property (nonatomic, strong) CAShapeLayer *roundLayer;
@property (nonatomic, assign) BOOL showMask;

- (void)hideMaskAnimated;

@end

@protocol ShopItemCellDelegate <NSObject>

- (void)cell:(ShopItemCell*)cell tapFavButton:(id)item;
- (void)cell:(ShopItemCell*)cell tapMoreButton:(id)item;

@end
