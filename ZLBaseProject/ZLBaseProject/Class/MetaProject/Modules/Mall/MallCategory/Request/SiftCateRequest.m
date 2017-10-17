//
//  SiftCateRequest.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "SiftCateRequest.h"

static NSString* const siftCateListUrl = @"/mall_wall_siftwall";

@implementation SiftCateRequest
+ (void)getMCCategoryDataWithParams:(NSDictionary *)params
                            success:(void (^)(TMCateSiftResultModel *))success
                            failure:(void (^)(StatusModel *))failure {
    [[ZLNetworkCaptain sharedInstance] getWithUrl:siftCateListUrl parameters:params success:^(NSDictionary *result) {
        TMCateSiftResultModel *cateResult = [TMCateSiftResultModel yy_modelWithDictionary:result];
        
        if (success) {
            success(cateResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}
@end
