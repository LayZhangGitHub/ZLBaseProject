//
//  AppMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#import "ZLThemeControl.h"
#import "ZLNavigationService.h"
#import "UserInfoService.h"

#import "ApplicationEntity.h"


#define AppScheme           @"xiaoma"
#define AppSchemeCompeled   @"xiaoma://"

#define LoginHost           @"login"
#define BecomeMemberHost    @"becomeMember"
#define SettingHost         @"setting"
#define TopUpHost           @"topUp"
#define ChangeGender        @"changeGender"
#define ChangeNick          @"changeNick"

#define _SConnect(x, y) [NSString stringWithFormat:@"%@%@", x,y]
#define SConnect(x, y) _SConnect(x, y)

#define LocalAppHost(x) SConnect(@"xiaoma://", x)

#endif /* AppMacro_h */
