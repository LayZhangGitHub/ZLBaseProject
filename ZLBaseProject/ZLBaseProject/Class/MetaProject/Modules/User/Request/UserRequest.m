//
//  UserRequest.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "UserRequest.h"

static NSString* const userLoginRequestUrl          = @"/user_user/login";
static NSString* const userThirdLoginRequestUrl     = @"/user_user/quick";
static NSString* const userRegisterRequestUrl       = @"/user_user/register";
static NSString* const userGetCaptchaRequestUrl     = @"/user_user/code";
static NSString* const userRegisterBindingRequestUrl= @"/user_user/bind";
static NSString* const userUploadTokenRequestUrl    = @"/user_user/setpushtoken";

static NSString* const userThirdBindRequestUrl      = @"/user_user/thirdbind";
static NSString* const userThirdInfoRequestUrl      = @"/user_user/thirdinfo";

static NSString* const checkUserIsregUrl            = @"/user_user/check";

@implementation UserRequest
+ (void)loginWithParams:(NSDictionary *)params success:(void(^)(TMUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    [[ZLNetworkCaptain sharedInstance] postWithUrl:userLoginRequestUrl parameters:params success:^(NSDictionary *result) {
        
        TMUserInfoResultModel *userInfoResult = [TMUserInfoResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(userInfoResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)thirdLoginWithParams:(NSDictionary *)params success:(void(^)(TMUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    [[ZLNetworkCaptain sharedInstance] postWithUrl:userThirdLoginRequestUrl parameters:params success:^(NSDictionary *result) {
        
        TMUserInfoResultModel *userInfoResult = [TMUserInfoResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(userInfoResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}


+ (void)registerWithParams:(NSDictionary *)params success:(void(^)(TMUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[ZLNetworkCaptain sharedInstance] postWithUrl:userRegisterRequestUrl parameters:params success:^(NSDictionary *result) {
        
        TMUserInfoResultModel *userInfoResult = [TMUserInfoResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(userInfoResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)thirdBindingWithParams:(NSDictionary *)params success:(void(^)(TMUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[ZLNetworkCaptain sharedInstance] postWithUrl:userRegisterBindingRequestUrl parameters:params success:^(NSDictionary *result) {
        
        TMUserInfoResultModel *userInfoResult = [TMUserInfoResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(userInfoResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)thirdBindWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure
{
    [[ZLNetworkCaptain sharedInstance] postWithUrl:userThirdBindRequestUrl parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)uploadPushTokenWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure
{
    [[ZLNetworkCaptain sharedInstance] postWithUrl:userUploadTokenRequestUrl parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)thirdInfoWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure
{
    [[ZLNetworkCaptain sharedInstance] getWithUrl:userThirdInfoRequestUrl parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success(result);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getCaptchaWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure
{
    [[ZLNetworkCaptain sharedInstance] getWithUrl:userGetCaptchaRequestUrl parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)checkRegisterWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure
{
    
    [[ZLNetworkCaptain sharedInstance] getWithUrl:checkUserIsregUrl parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success(result);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}


@end
