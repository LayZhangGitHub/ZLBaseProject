//
//  ShopHeadCell.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseCollectionCell.h"


@protocol ShopHeadCellDelegate;

@interface ShopHeadCell : BaseCollectionCell

@property (nonatomic, weak) id<ShopHeadCellDelegate> delegate;

@end


@protocol ShopHeadCellDelegate <NSObject>
- (void)addFavShop:(UIButton *)sender;
- (void)cancelFavShop:(UIButton *)sender;
@end
