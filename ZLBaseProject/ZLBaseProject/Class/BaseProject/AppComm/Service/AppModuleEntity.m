//
//  AppModuleEntity.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/21.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "AppModuleEntity.h"
#import "ZLNavigationService.h"

@implementation AppModuleEntity

+ (id)shareInstance {
    static dispatch_once_t onceToken;
    static AppModuleEntity *appModelEntity = nil;
    dispatch_once(&onceToken, ^{
        appModelEntity = [[AppModuleEntity alloc] init];
    });
    return appModelEntity;
}

+ (void)load {
    
}

@end
