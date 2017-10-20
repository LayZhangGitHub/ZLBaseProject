//
//  ShopInfoResultModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShopInfoModel.h"
#import "ShopTabModel.h"
#import "ShopItemsModel.h"
#import "ShareInfoModel.h"

@interface ShopInfoResultModel : NSObject

@property (nonatomic, strong) ShopInfoModel *shopInfo;
@property (nonatomic, strong) NSArray<ShopTabModel *> *tab;
@property (nonatomic, strong) ShopItemsModel *items;
@property (nonatomic, strong) ShareInfoModel *share;

@end
