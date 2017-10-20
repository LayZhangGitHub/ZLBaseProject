//
//  ShopItemsModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopItemModel.h"

@interface ShopItemsModel : NSObject

@property (nonatomic, strong) NSString *template;
@property (nonatomic, strong) NSArray<ShopItemModel *> *list;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSString *wp;

@end
