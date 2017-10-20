//
//  ShopItemModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopItemDetailModel.h"

@interface ShopItemModel : NSObject

@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) ShopItemDetailModel *content;

@end
