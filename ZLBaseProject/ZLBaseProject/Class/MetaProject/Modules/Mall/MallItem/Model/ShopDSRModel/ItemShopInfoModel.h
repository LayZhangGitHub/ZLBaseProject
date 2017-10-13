//
//  ItemShopInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSRModel.h"

@interface ItemShopInfoModel : NSObject

@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *discountInfo;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *sales;      // 销量
@property (nonatomic, strong) NSString *favCount;   // 收藏量
@property (nonatomic, strong) NSString *itemCount;  // 商品数量
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) DSRModel *dsr;        // 商店 动态评分

@end
