//
//  UserInfoService.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserInfoService : NSObject

@property (nonatomic, strong) UserInfo *userInfo;

+ (instancetype)shareUserInfo;

- (void)saveData;
- (void)clearData;
- (void)logoutAndClearData;
- (void)loginAndSaveData;

@end
