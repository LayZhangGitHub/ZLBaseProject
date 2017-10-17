//
//  TMCateSiftResultModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstModel.h"
#import "TMCateSiftModel.h"
#import "TMCateModuleModel.h"

@interface TMCateSiftResultModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) InstModel *items;

@property (nonatomic,strong) NSArray<TMCateSiftModel *> *sifts;
@property (nonatomic,strong) NSArray<TMCateModuleModel *> *categories;

@end
