//
//  ApplicationEntity.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/21.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ApplicationEntity.h"

@implementation ApplicationEntity

+ (instancetype)shareInstance {
    static ApplicationEntity *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ApplicationEntity alloc] init];
    });
    return instance;
}

#pragma mark - application system
- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions {
    [super applicationEntrance:mainWindow launchOptions:launchOptions];
    
    [self initViewControllers];
    
}

- (void)applicationEnterForeground {
    [super applicationEnterForeground];
}

- (void)applicationActive {
    [super applicationActive];
}

- (void)applicationEnterBackground {
    [super applicationEnterBackground];
}

- (void)handleOpenURL:(NSString *)aUrl{
    [super handleOpenURL:aUrl];
}

- (void)applicationRegisterDeviceToken:(NSData*)deviceToken {
    [super applicationRegisterDeviceToken:deviceToken];
}

- (void)applicationFailToRegisterDeviceToken:(NSError*)error {
    [super applicationFailToRegisterDeviceToken:error];
}

- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo {
    [super applicationReceiveNotifaction:userInfo];
}

- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation { return YES; }

- (BOOL)applicationHandleOpenURL:(NSURL *)url { return YES; }

- (void)applicationPerformFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    completionHandler(UIBackgroundFetchResultNewData);
    
    [self didReceiveRemoteNotification:userInfo];
}

#pragma mark - custom
- (void)didReceiveRemoteNotification:(NSDictionary*)userInfo {
}

#pragma mark - init controllers
- (void)initViewControllers {
    
}

@end

