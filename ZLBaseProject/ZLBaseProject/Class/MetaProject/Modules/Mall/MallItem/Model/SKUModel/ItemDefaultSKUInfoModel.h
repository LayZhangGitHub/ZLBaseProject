//
//  ItemDefaultSKUInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 基础 SKU 信息
 **/
@interface ItemDefaultSKUInfoModel : NSObject

@property (nonatomic, assign) NSInteger quantity; //总库存
@property (nonatomic, strong) NSString *price;    //基础价格

@end
