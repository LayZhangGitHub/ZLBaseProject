//
//  ShopInfoResultModel.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopInfoResultModel.h"

@implementation ShopInfoResultModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tab" : [ShopTabModel class]};
}
@end
