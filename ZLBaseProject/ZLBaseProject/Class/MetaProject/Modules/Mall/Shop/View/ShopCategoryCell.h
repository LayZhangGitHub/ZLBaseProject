//
//  ShopCategoryCell.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseCollectionCell.h"

@protocol ShopCategoryCellDelegate;

@interface ShopCategoryCell : BaseCollectionCell

@property (nonatomic, weak) id<ShopCategoryCellDelegate> delegate;

@end

@protocol ShopCategoryCellDelegate <NSObject>

- (void)cellTapCate:(id)model;

@end
