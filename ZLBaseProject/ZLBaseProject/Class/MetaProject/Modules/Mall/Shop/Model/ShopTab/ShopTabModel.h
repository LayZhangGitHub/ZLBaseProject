//
//  ShopTabModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopTabCateModel.h"

// 店铺上级分类
@interface ShopTabModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSArray<ShopTabCateModel *> *list;

@end
