//
//  PMCategoryResultModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PMCategoryResultModel.h"

@implementation PMCategoryResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [PMItemModel class]};
}

@end
