//
//  ScreenMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef ScreenMacro_h
#define ScreenMacro_h

#import "ShowToast.h"


/** screen util**/
#pragma mark - screen
#define Screen [UIScreen mainScreen]
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREENSCALE [UIScreen mainScreen].scale
#define LINEWIDTH   1.f / [UIScreen mainScreen].scale
#define STATUSBARHEIGHT             20.f
#define NAVBARCONTAINERHEIGHT       44.f
#define NAVBARHEIGHT                (NAVBARCONTAINERHEIGHT + STATUSBARHEIGHT)

/** color **/
#pragma mark - color
#define ZLWhiteColor    [UIColor whiteColor]
#define ZLClearColor    [UIColor clearColor]
#define ZLBlackColor    [UIColor blackColor]
#define ZLRedColor      [UIColor redColor]

#define ZLRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define ZLRGB(r,g,b)    ZLRGBA(r,g,b,1)
#define ZLGray(g)       ZLRGB(g,g,g)

#define ZLHEXA(hex,a)       [UIColor colorWithHexString:hex alpha:a]
#define ZLHEX(hex)          CHEXA(hex,1)

/** font **/
#pragma mark - font
#define ZLBoldFont(x)   [UIFont boldSystemFontOfSize:(x)]
#define ZLNormalFont(x) [UIFont systemFontOfSize:(x)]
#define ZLItalicFont(x) [UIFont italicSystemFontOfSize:(x)]

#pragma mark - scale
#define SCALE (SCREENWIDTH/750.0)

#endif /* ScreenMacro_h */
