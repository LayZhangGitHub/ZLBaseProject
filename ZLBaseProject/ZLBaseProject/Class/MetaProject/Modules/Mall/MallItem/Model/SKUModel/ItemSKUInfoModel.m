//
//  ItemSKUInfoModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemSKUInfoModel.h"

@implementation ItemSKUInfoModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"properties" : [ItemPropertyModel class],
             @"stockInfo" : [ItemStockInfoModel class],
             @"covers" : [ItemSKUCoverModel class]
             };
}


@end
