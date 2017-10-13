//
//  ItemPropertyModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemPropertyKVModel.h"

@interface ItemPropertyModel : NSObject

@property (nonatomic, strong) NSString *propertyName;                           // 规格名称 （颜色、码）
@property (nonatomic, strong) NSArray<ItemPropertyKVModel *> *propertyValueList;  // 具体属性 （蓝色、40码）

@end
