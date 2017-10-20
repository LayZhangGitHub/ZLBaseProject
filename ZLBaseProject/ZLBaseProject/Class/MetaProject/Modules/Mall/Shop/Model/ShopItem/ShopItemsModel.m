//
//  ShopItemsModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopItemsModel.h"

@implementation ShopItemsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ShopItemModel class]};
}
@end
