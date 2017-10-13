//
//  ItemStockInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 库存信息
 **/
@interface ItemStockInfoModel : NSObject

@property (nonatomic, strong) NSString *image;      // image url
@property (nonatomic, assign) NSInteger quantity;   // sku 的 存量
@property (nonatomic, strong) NSString *price;      // sku 的 价格
@property (nonatomic, strong) NSString *skuId;      // skuId

@end
