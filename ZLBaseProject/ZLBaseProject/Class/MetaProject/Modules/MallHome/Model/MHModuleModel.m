//
//  MHModuleModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModuleModel.h"

@implementation MHModuleModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[MHItemModel class]};
}

@end
