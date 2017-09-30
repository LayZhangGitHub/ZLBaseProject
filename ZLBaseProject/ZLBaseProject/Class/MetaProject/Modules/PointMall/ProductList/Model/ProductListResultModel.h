//
//  ProductListResultModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMListItemMOdel.h"
#import "PMCatesModel.h"

@interface ProductListResultModel : NSObject

@property (nonatomic,strong) NSArray<PMListItemMOdel *> *list;
@property (nonatomic,strong) NSArray<PMCatesModel *> *cates;
@property (nonatomic,copy) NSString *wp;
@property (nonatomic,assign) BOOL isEnd;

@end
