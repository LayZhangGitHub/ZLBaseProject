//
//  TMCateSiftModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMCateSiftModel.h"

@implementation TMCateSiftModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"options" : [TMCateSiftOptionModel class]};
}

@end
