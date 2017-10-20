//
//  ShopTabModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopTabModel.h"

@implementation ShopTabModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ShopTabCateModel class]};
}

@end
