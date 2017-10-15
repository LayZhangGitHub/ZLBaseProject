//
//  ItemToolBarView.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLMyBaseView.h"

#define StatusOnSell          @"0"
#define StatusSellOut         @"1"
#define StatusUnderCarriage   @"2"


@protocol ItemToolBarDelegate;

@interface ItemToolBarModel : NSObject

+ (instancetype)modelWithIsFav:(BOOL)isFav status:(NSString *)status;

@property (nonatomic, assign) BOOL isFav;       // 是否收藏
@property (nonatomic, strong) NSString *status; // 销售 状态  正常、售罄、下架

@end

@interface ItemToolBarView : ZLMyBaseView

@property (nonatomic, strong) ItemToolBarModel *model;

@property (nonatomic, weak) id<ItemToolBarDelegate> delegate;

@end

@protocol ItemToolBarDelegate <NSObject>

- (void)chatButtonDidClick;             // 客服聊天
- (void)myCollectionButtonDidClick;     // 收藏
- (void)shopButtonDidClick;             // 商铺link
- (void)addToCartButtonDidClick;        // 加入购物车
- (void)buyButtonDidClick;              // 购买

@end
