//
//  NSString+ZLEX.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSString+ZLEX.h"
#import <UIKit/UIKit.h>

@implementation NSString (ZLEX)

- (void)showNotice{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                                                       message:self
                                                      delegate:self
                                             cancelButtonTitle:@"知道了"
                                             otherButtonTitles:nil];
    
    
    [alertView show];
}

- (NSString *)trim {
    if( self == nil || [self isKindOfClass:[NSNull class]] ) {
        return nil;
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isEmptyString {
    if (!self || [self.trim isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (CGSize)sizeWithUIFont:(UIFont *)font forWidth:(CGFloat)width {
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [self sizeWithUIAttribute:attribute forWidth:width];
    return size;
}

- (CGSize)sizeWithUIAttribute:(NSDictionary *)attribute forWidth:(CGFloat)width {
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size;
}

- (CGSize)sizeWithSize:(CGSize)size font:(NSInteger)font {
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}

- (NSString *)urldecode {
    return [[self stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlencode {
    static NSString * const kCharactersToLeaveUnescapedInQueryStringPairKey = @"[].";
    static NSString * const kCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, (__bridge CFStringRef)kCharactersToLeaveUnescapedInQueryStringPairKey, (__bridge CFStringRef)kCharactersToBeEscapedInQueryString, kCFStringEncodingUTF8);
}

@end
