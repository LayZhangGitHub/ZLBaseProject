//
//  ShowToast.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShowToast.h"

@implementation ShowToast

+ (void)showNotice:(NSString *)notice {
    [self showNotice:notice duraton:1.0f];
}

+ (void)showNotice:(NSString *)notice duraton:(NSTimeInterval)duration {
    CGFloat height = 90 * SCALE;
    CGSize size = [notice sizeWithSize:CGSizeMake(SCREENWIDTH, height) font:15];
    CGFloat width = size.width + 60 * SCALE;
    
    UILabel *label = [UILabel labelWithText:notice textColor:[UIColor whiteColor] font:15 textAliment:NSTextAlignmentCenter];
    
    label.layer.cornerRadius = 16*SCALE;
    label.clipsToBounds = YES;
    
    label.frame = CGRectMake(SCREENWIDTH/2 - width/2, SCREENHEIGHT/2 - 45 * SCALE, width, height);
    
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0;
    
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    [UIView animateWithDuration:0.25 animations:^{
        label.alpha = 0.6;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    });
}

@end
