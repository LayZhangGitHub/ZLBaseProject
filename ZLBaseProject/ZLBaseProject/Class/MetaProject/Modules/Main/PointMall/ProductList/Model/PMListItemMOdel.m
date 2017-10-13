//
//  PMListItemMOdel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PMListItemMOdel.h"

@implementation PMListItemMOdel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [PMItemModel class]};
}


@end
