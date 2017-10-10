//
//  MineRequest.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MineRequest.h"

static NSString* const mineRequestUrl               = @"/user_me";
static NSString* const mineChangeAvatarRequestUrl   = @"/user_me/changeavatar";
static NSString* const mineChangeNameRequestUrl     = @"/user_me/changename";
static NSString* const mineChangeGenderRequestUrl   = @"/user_me/changegender";
static NSString* const mineGetVipDataRequestUrl     = @"/user_me/vip";
static NSString* const becomeMemberRequestUrl       = @"/pay_vip/submit";


@implementation MineRequest

+ (void)getMineDataWithParams:(NSDictionary *)params success:(void(^)(TMMineInfoModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] getWithUrl:mineRequestUrl parameters:params success:^(NSDictionary *result) {
        TMMineInfoModel *mineResult = [TMMineInfoModel yy_modelWithDictionary:result];
        
        if (success) {
            success(mineResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)changeAvatarWithParams:(NSDictionary *)params image:(UIImage *)image success:(void(^)(TMChangeAvatarResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] postImageWithUrl:mineChangeAvatarRequestUrl image:image parameters:params progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSDictionary *result) {
        
        TMChangeAvatarResultModel *changeAvatarResult = [TMChangeAvatarResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(changeAvatarResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)changeNameWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] postWithUrl:mineChangeNameRequestUrl parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)changeGenderWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure {
    
    [[ZLNetworkCaptain sharedInstance] postWithUrl:mineChangeGenderRequestUrl parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getVipDataWithParams:(NSDictionary *)params success:(void (^)(TMVipModel *))success failure:(void (^)(StatusModel *))failure {
    [[ZLNetworkCaptain sharedInstance] getWithUrl:mineGetVipDataRequestUrl parameters:params success:^(NSDictionary *result) {
        TMVipModel *vipModel = [TMVipModel yy_modelWithDictionary:result];
        
        if (success) {
            success(vipModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)becomeMemberWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *result))success failure:(void (^)(StatusModel *))failure {
    [[ZLNetworkCaptain sharedInstance] getWithUrl:becomeMemberRequestUrl parameters:params success:^(NSDictionary *result) {
        
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
