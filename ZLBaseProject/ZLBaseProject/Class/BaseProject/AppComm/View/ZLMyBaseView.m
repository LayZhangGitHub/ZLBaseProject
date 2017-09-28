//
//  ZLMyBaseView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/28.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLMyBaseView.h"

@implementation ZLMyBaseView

- (instancetype)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    // 子类实现
}

- (void)updateConstraints {
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end
