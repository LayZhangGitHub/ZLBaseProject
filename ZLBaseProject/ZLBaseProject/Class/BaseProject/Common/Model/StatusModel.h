//
//  StatusModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, StatusCode) {
    StatusCodeNone                  = 0,
    StatusCodeSuccess               = 1001,
    StatusCodeUnlogin               = 1002,
    StatusCodeFailed                = 404,
    StatusCodeUnregistered          = 1003,
    StatusCodeCaptchaCodeErr        = 1120, // 验证码 错误
};

@interface StatusModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *msg;

@end
