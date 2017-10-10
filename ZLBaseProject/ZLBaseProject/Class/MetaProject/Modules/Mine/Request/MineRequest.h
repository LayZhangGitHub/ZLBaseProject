//
//  MineRequest.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLNetworkCaptain.h"

#import "TMMineInfoModel.h"
#import "TMChangeAvatarResultModel.h"
#import "TMVipModel.h"

@interface MineRequest : NSObject

+ (void)getMineDataWithParams:(NSDictionary *)params success:(void(^)(TMMineInfoModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)changeAvatarWithParams:(NSDictionary *)params image:(UIImage *)image success:(void(^)(TMChangeAvatarResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)changeNameWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

+ (void)changeGenderWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

+ (void)getVipDataWithParams:(NSDictionary *)params success:(void(^)(TMVipModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)becomeMemberWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;
@end
