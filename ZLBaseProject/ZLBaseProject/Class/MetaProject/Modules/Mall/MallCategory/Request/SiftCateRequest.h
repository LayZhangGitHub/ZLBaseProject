//
//  SiftCateRequest.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLNetworkCaptain.h"

#import "TMCateSiftResultModel.h"

@interface SiftCateRequest : NSObject

+ (void)getMCCategoryDataWithParams:(NSDictionary *)params
                            success:(void(^)(TMCateSiftResultModel *resultModel))success
                            failure:(void(^)(StatusModel *status))failure;

@end
