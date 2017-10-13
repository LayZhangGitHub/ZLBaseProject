//
//  ProductListResultModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ProductListResultModel.h"

@implementation ProductListResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [PMListItemMOdel class],
             @"cates": [PMCatesModel class]};
}


@end
