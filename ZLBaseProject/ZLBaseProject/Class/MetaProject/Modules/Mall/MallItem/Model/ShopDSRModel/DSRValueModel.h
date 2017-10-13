//
//  DSRValueModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 商铺评分
 **/
@interface DSRValueModel : NSObject

@property (nonatomic, strong) NSString *v; // 分数 (5分制)
@property (nonatomic, strong) NSString *d; // 等级 (高、中、低)

@end
