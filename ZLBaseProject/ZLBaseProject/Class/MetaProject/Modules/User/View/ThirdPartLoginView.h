//
//  ThirdPartLoginView.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLMyBaseView.h"


@protocol ThirdPartLoginViewDelegate <NSObject>

- (void)weiboAuthorizeLogin;//微博授权登录
- (void)wechatAuthorizeLogin;//微信授权登录
- (void)tencentAuthorizeLogin;//QQ授权登录

@end

@interface ThirdPartLoginView : ZLMyBaseView


@property (nonatomic, assign) BOOL hideName;

@property (nonatomic, weak) id <ThirdPartLoginViewDelegate> delegate;


@end
