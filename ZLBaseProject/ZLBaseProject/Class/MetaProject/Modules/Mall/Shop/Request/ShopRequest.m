//
//  ShopRequest.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopRequest.h"

static NSString *const shopMallUrl          = @"/mall_shop";
static NSString *const shopFollowUrl        = @"/mall_shop/follow";
static NSString *const shopUnfollowUrl      = @"/mall_shop/unfollow";

@implementation ShopRequest

+ (void)getShopDataWithParams:(NSDictionary *)params success:(void(^)(ShopInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] getWithUrl:shopMallUrl parameters:params success:^(NSDictionary *result) {
        ShopInfoResultModel *shopResult = [ShopInfoResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(shopResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)followWithParams:(NSDictionary *)params success:(void(^)(ShopFavResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] postWithUrl:shopFollowUrl parameters:params success:^(NSDictionary *result) {
        ShopFavResultModel *favResult = [ShopFavResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(favResult);
        }
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)unfollowWithParams:(NSDictionary *)params success:(void(^)(ShopFavResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] postWithUrl:shopUnfollowUrl parameters:params success:^(NSDictionary *result) {
        ShopFavResultModel *favResultModel = [ShopFavResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(favResultModel);
        }
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
