//
//  MallHomeRequest.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MallHomeRequest.h"

static NSString* const homeDataRequestUrl       = @"/mall_index";
static NSString* const categoryDataRequestUrl   = @"/mall_category";

@implementation MallHomeRequest

+ (void)getHomeDataWithParams:(NSDictionary *)params success:(void(^)(MHResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[ZLNetworkCaptain sharedInstance] getWithUrl:homeDataRequestUrl parameters:params success:^(NSDictionary *result) {
        
        MHResultModel *mineResult = [MHResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(mineResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getCategoryDataWithParams:(NSDictionary *)params success:(void(^)(MHResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[ZLNetworkCaptain sharedInstance] getWithUrl:categoryDataRequestUrl parameters:params success:^(NSDictionary *result) {
        
        MHResultModel *mineResult = [MHResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(mineResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
