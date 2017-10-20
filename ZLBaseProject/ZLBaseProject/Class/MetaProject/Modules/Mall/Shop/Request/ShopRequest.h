//
//  ShopRequest.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLNetworkCaptain.h"

#import "ShopFavResultModel.h"
#import "ShopInfoResultModel.h"

@interface ShopRequest : NSObject
+ (void)getShopDataWithParams:(NSDictionary *)params success:(void(^)(ShopInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)followWithParams:(NSDictionary *)params success:(void(^)(ShopFavResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)unfollowWithParams:(NSDictionary *)params success:(void(^)(ShopFavResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
