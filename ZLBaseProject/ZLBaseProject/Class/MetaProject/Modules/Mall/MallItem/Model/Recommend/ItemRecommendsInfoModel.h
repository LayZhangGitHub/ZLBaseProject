//
//  ItemRecommendsInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemRecommendModel.h"

@interface ItemRecommendsInfoModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<ItemRecommendModel *> *list;

@end
