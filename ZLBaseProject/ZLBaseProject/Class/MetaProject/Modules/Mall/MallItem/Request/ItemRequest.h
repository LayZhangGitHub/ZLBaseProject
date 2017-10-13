//
//  ItemRequest.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLNetworkCaptain.h"

#import "ItemResultModel.h"


@interface ItemRequest : NSObject

+ (void)getItemDataWithParams:(NSDictionary *)params success:(void(^)(ItemResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)followWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

+ (void)unfollowWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

//+ (void)getSupportContactWithParams:(NSDictionary *)params success:(void(^)(ITSupportContactResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
