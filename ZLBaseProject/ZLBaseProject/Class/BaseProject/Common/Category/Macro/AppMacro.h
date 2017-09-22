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

#define AppScheme           @"xiaoma"
#define AppSchemeCompeled   @"xiaoma://"

#define LoginHost           @"login"

#define _SConnect(x, y) [NSString stringWithFormat:@"%@,%@", x,y]
#define SConnect(x, y) _SConnect(x, y)

#endif /* AppMacro_h */
