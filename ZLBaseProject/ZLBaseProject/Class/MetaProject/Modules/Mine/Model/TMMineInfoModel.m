//
//  TMMineInfoModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMMineInfoModel.h"

@implementation TMMineInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orderPendingCount" : [TMMineOrderModel class]};
}

@end
