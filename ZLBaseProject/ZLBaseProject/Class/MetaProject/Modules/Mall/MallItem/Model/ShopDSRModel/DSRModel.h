//
//  DSRModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSRValueModel.h"

/**
 商铺具体评分
 */
@interface DSRModel : NSObject

@property (nonatomic, strong) DSRValueModel *ms; // 描述相符
@property (nonatomic, strong) DSRValueModel *zl; // 质量合格
@property (nonatomic, strong) DSRValueModel *jg; // 价格合理
@property (nonatomic, strong) DSRValueModel *qb; // 综合评分

@end
