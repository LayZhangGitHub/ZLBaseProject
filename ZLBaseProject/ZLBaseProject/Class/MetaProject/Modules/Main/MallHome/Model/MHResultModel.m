//
//  MHResultModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHResultModel.h"

@implementation MHResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [MHModuleModel class]};
}

@end
