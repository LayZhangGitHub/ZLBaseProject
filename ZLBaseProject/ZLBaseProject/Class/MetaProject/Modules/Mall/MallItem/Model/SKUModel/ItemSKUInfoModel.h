//
//  ItemSKUInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ItemPropertyModel.h"
#import "ItemStockInfoModel.h"
#import "ItemSKUCoverModel.h"
#import "ItemDefaultSKUInfoModel.h"

@interface ItemSKUInfoModel : NSObject

@property (nonatomic, strong) NSArray<ItemPropertyModel *> *properties;
@property (nonatomic, strong) NSDictionary<NSString *, ItemStockInfoModel *> *stockInfo; // property key
@property (nonatomic, strong) NSArray<ItemSKUCoverModel *> *covers;
@property (nonatomic, strong) ItemDefaultSKUInfoModel *defaultInfo;                     

@end
