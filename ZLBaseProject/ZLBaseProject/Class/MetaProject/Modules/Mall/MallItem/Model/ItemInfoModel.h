//
//  ItemInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemCoverImageModel.h"
#import "ItemSKUInfoModel.h"
#import "ItemDetailContentModel.h"

@interface ItemInfoModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *oPrice;
@property (nonatomic, strong) NSString *discountAmount;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *discountInfo;
@property (nonatomic, strong) ItemCoverImageModel *coverImage;
@property (nonatomic, strong) NSArray<ItemDetailContentModel *> *detailContent;
@property (nonatomic, strong) NSString *sales;  // 销量
@property (nonatomic, strong) ItemSKUInfoModel *skuInfo;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *servicePrice; // 在result中

@end
