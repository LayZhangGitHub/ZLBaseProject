//
//  ItemPropertyModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemPropertyModel.h"

@implementation ItemPropertyModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"propertyValueList" : [ItemPropertyKVModel class]
             };
}

@end
