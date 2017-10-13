//
//  PointMallRequest.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PointMallRequest.h"

// creidt request
static NSString * const creditRequestUrl             = @"/pointmall_index";
static NSString * const creditRequestMoreUrl         = @"/pointmall_wall";
static NSString * const creditRequestDetailUrl       = @"/pointmall_item";

static NSString * const creditOrderGenerateRequestUrl    = @"/mall_order/generate";
static NSString * const creditCartSubmitRequestUrl       = @"/mall_order/confirm";

static NSString * const pmOrderListRequestUrl            = @"/pointmall_order/list";
static NSString * const pmOrderListMoreRequestUrl        = @"/pointmall_order/listmore";

static NSString * const pmOrderDetailRequestUrl          = @"/pointmall_order";

//订单确认收货
static NSString * const pmOrderReceiveRequestUrl         = @"/pointmall_order/receive";
// 删除订单
static NSString * const pmOrderDeleteRequestUrl          = @"/pointmall_order/delete";

static NSString * const pointDetailRequestUrl            = @"/pointmall_point/details";
static NSString * const pointCategoryRequestUrl          = @"/pointmall_category";
static NSString * const pointSearchRequestUrl            = @"/pointmall_search";


@implementation PointMallRequest

+ (void)getProductListDataWithParams:(NSDictionary *)params success:(void(^)(ProductListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] getWithUrl:creditRequestUrl parameters:params success:^(NSDictionary *result) {
        
        ProductListResultModel *productListResult = [ProductListResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(productListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getProductMoreDataWithParams:(NSDictionary *)params success:(void(^)(ProductListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] getWithUrl:creditRequestMoreUrl parameters:params success:^(NSDictionary *result) {
        
        ProductListResultModel *productListResult = [ProductListResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(productListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

//+ (void)orderGenerateWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure {
//
//    [[TTNetworkManager sharedInstance] postWithUrl:CREDIT_ORDER_GENERATE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
//        if (success) {
//
//            success(result);
//        }
//
//    } failure:^(StatusModel *status) {
//        if (failure) {
//            failure(status);
//        }
//    }];
//
//}
//
////积分订单删除
//+ (void)deleteOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
//{
//    [[TTNetworkManager sharedInstance] getWithUrl:PMORDER_DELETE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
//
//        if (success) {
//            success();
//        }
//
//    } failure:^(StatusModel *status) {
//        if (failure) {
//            failure(status);
//        }
//    }];
//}
//
////积分订单确认收货
//+ (void)receiptOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
//{
//    [[TTNetworkManager sharedInstance] getWithUrl:PMORDER_RECEIPT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
//
//        if (success) {
//            success();
//        }
//
//    } failure:^(StatusModel *status) {
//        if (failure) {
//            failure(status);
//        }
//    }];
//}
//
//+ (void)getPointDetailWithParams:(NSDictionary *)params success:(void (^)(PointDetailResultModel *))success failure:(void (^)(StatusModel *))failure
//{
//    [[TTNetworkManager sharedInstance] getWithUrl:POINT_DETAIL_REQUEST_URL parameters:params success:^(NSDictionary *result) {
//
//        NSError *err = [[NSError alloc] init];
//
//        PointDetailResultModel *pointdetaliResult = [[PointDetailResultModel alloc] initWithDictionary:result error:&err];
//
//        if (success) {
//            success(pointdetaliResult);
//        }
//
//    } failure:^(StatusModel *status) {
//        if (failure) {
//            failure(status);
//        }
//    }];
//}
//
//+ (void)getPointMallCategoryWithParams:(NSDictionary *)params success:(void (^)(PMCategoryResultModel *))success failure:(void (^)(StatusModel *))failure
//{
//    [[TTNetworkManager sharedInstance] getWithUrl:POINT_CATEGORY_REQUEST_URL parameters:params success:^(NSDictionary *result) {
//
//        NSError *err = [[NSError alloc] init];
//
//        PMCategoryResultModel *pointdetaliResult = [[PMCategoryResultModel alloc] initWithDictionary:result error:&err];
//
//        if (success) {
//            success(pointdetaliResult);
//        }
//
//    } failure:^(StatusModel *status) {
//        if (failure) {
//            failure(status);
//        }
//    }];
//}
//
//
//+ (void)getSearchDataWithParams:(NSDictionary *)params success:(void (^)(PMCategoryResultModel *))success failure:(void (^)(StatusModel *))failure
//{
//    [[TTNetworkManager sharedInstance] getWithUrl:POINT_SEARCH_REQUEST_URL parameters:params success:^(NSDictionary *result) {
//
//        NSError *err = [[NSError alloc] init];
//
//        PMCategoryResultModel *pointdetaliResult = [[PMCategoryResultModel alloc] initWithDictionary:result error:&err];
//
//        if (success) {
//            success(pointdetaliResult);
//        }
//
//    } failure:^(StatusModel *status) {
//        if (failure) {
//            failure(status);
//        }
//    }];
//}

@end
