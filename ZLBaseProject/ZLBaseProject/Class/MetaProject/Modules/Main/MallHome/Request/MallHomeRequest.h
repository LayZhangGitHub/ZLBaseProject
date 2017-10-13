//
//  MallHomeRequest.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLNetworkCaptain.h"
#import "MHResultModel.h"

@interface MallHomeRequest : NSObject

+ (void)getHomeDataWithParams:(NSDictionary *)params success:(void(^)(MHResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getCategoryDataWithParams:(NSDictionary *)params success:(void(^)(MHResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
