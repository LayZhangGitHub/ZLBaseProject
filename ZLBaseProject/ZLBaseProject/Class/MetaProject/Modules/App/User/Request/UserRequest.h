//
//  UserRequest.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMUserInfoResultModel.h"
#import "ZLNetworkCaptain.h"

@interface UserRequest : NSObject

//登录注册相关
+ (void)loginWithParams:(NSDictionary *)params success:(void(^)(TMUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)thirdLoginWithParams:(NSDictionary *)params success:(void(^)(TMUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


+ (void)registerWithParams:(NSDictionary *)params success:(void(^)(TMUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)thirdBindingWithParams:(NSDictionary *)params success:(void(^)(TMUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getCaptchaWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

+ (void)thirdBindWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;
+ (void)thirdInfoWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;

+ (void)uploadPushTokenWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

+ (void)checkRegisterWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;


@end
