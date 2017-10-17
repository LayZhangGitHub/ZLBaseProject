//
//  TMCateSiftResultModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMCateSiftResultModel.h"

@implementation TMCateSiftResultModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"sifts" : [TMCateSiftModel class],
             @"categories" : [TMCateModuleModel class]
             };
}
@end
