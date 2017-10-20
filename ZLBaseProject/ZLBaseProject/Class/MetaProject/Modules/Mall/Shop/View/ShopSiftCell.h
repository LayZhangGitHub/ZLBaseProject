//
//  ShopSiftCell.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseCollectionCell.h"

@protocol ShopSiftCellDelaget;

@interface ShopSiftCell : BaseCollectionCell

@property (nonatomic, weak) id<ShopSiftCellDelaget> delegate;

@end

@protocol ShopSiftCellDelaget <NSObject>

- (void)cellTapSift:(id)model;

@end
