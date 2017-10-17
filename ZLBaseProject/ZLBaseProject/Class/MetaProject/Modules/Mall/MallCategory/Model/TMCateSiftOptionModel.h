//
//  TMCateSiftModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 筛选条件顺序（多到少、贵到便宜）
 */
@interface TMCateSiftOptionModel : NSObject

@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *desc;

@end
