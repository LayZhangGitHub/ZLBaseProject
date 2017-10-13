//
//  TMUserInfoResultModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMUserInfoResultModel.h"

@implementation TMUserInfoResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user" : [TMUserInfoModel class]};
}

@end
