//
//  PointMallRequest.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLNetworkCaptain.h"

#import "ProductListResultModel.h"

@interface PointMallRequest : NSObject

+ (void)getProductListDataWithParams:(NSDictionary *)params
                             success:(void(^)(ProductListResultModel *resultModel))success
                             failure:(void(^)(StatusModel *status))failure;

+ (void)getProductMoreDataWithParams:(NSDictionary *)params
                             success:(void(^)(ProductListResultModel *resultModel))success
                             failure:(void(^)(StatusModel *status))failure;


//积分兑换
//+ (void)orderGenerateWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;

//积分兑换列表


//积分订单详情

//积分订单删除
//+ (void)deleteOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

//积分订单确认收货
//+ (void)receiptOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;


// 积分明细
//+ (void)getPointDetailWithParams:(NSDictionary *)params success:(void(^)(PointDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
//
//
//+ (void)getPointMallCategoryWithParams:(NSDictionary *)params success:(void(^)(PMCategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
//
//
//+ (void)getSearchDataWithParams:(NSDictionary *)params success:(void(^)(PMCategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
