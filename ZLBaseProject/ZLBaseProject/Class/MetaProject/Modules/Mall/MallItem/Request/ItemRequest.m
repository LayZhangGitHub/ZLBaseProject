//
//  ItemRequest.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemRequest.h"

static NSString *const itemRequestUrl         =  @"/mall_item";
static NSString *const itemFollowRequestUrl   =  @"/mall_item/follow";
static NSString *const itemUnfollowRequestUrl =  @"/mall_item/unfollow";
static NSString *const itemSupportRequestUrl  =  @"/zbh_service";


@implementation ItemRequest


+ (void)getItemDataWithParams:(NSDictionary *)params success:(void(^)(ItemResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] getWithUrl:itemRequestUrl parameters:params success:^(NSDictionary *result) {

        ItemResultModel *itemResult = [ItemResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)followWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] postWithUrl:itemFollowRequestUrl parameters:params success:^(NSDictionary *result) {
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)unfollowWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] postWithUrl:itemUnfollowRequestUrl parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
