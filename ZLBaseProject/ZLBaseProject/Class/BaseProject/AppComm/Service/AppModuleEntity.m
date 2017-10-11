//
//  AppModuleEntity.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/21.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "AppModuleEntity.h"
#import "ZLNavigationService.h"
#import "View01Controller.h"
#import "ApplicationEntity.h"

#import "UserInfoService.h"

#import "LoginController.h"
#import "BecomeMemberController.h"
#import "SettingController.h"
#import "TMChangeNickController.h"
#import "TMChangeGenderController.h"

@implementation AppModuleEntity

+ (id)shareEntity {
    static dispatch_once_t onceToken;
    static AppModuleEntity *appModelEntity = nil;
    dispatch_once(&onceToken, ^{
        appModelEntity = [[AppModuleEntity alloc] init];
    });
    return appModelEntity;
}

+ (void)load {
    NSArray *hosts = @[LoginHost, BecomeMemberHost, SettingHost, ChangeGender, ChangeNick];
    for (NSString *host in hosts) {
        [[ZLNavigationService sharedService] registerModule:self
                                                 withScheme:AppScheme
                                                       host:host];
    }
}


- (BOOL)canOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from {
    return YES;
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void(^)(void))complete {
    ZLNavigationController *navigationController = [[ApplicationEntity shareInstance] currentNavigationController];
    
    NSString *strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableDictionary *urlParams = [[url parameters] mutableCopy];
    if ([url.host isEqualToString:LoginHost]) {
        [[UserInfoService shareUserInfo] clearData];
        [[ApplicationEntity shareInstance].tabbarController setSelectIndex:0];
        
        UIViewController *topVC = navigationController.topViewController;
        if ([topVC isKindOfClass:[LoginController class]]) {
            return;
        }
        if([navigationController.childViewControllers count] > 1){
            [navigationController popToRootViewControllerAnimated:NO];
            
        }
        LoginController *vc = [[LoginController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([url.host isEqualToString:BecomeMemberHost]) {
        BecomeMemberController *vc = [[BecomeMemberController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([url.host isEqualToString:SettingHost]) {
        SettingController *vc = [[SettingController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([url.host isEqualToString:ChangeNick]) {
        TMChangeNickController *vc = [[TMChangeNickController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([url.host isEqualToString:ChangeGender]) {
        TMChangeGenderController *vc = [[TMChangeGenderController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
}
@end
