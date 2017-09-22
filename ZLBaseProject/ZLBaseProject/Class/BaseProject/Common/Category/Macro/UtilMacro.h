//
//  UtilMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h

// button delay
#define DelayEnableButton(s, t) UIButton *enableButton = (UIButton *)s;\
enableButton.enabled = NO;\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
enableButton.enabled = YES;\
});

//weakSelf & strongSelf
#define weakSelf( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(weak))) __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#define strongSelf( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(strong))) __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#endif /* UtilMacro_h */
