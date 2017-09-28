//
//  MHModuleModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHHeaderModel.h"
#import "MHBannerModel.h"
#import "MHItemModel.h"

@interface MHModuleModel : NSObject

@property (nonatomic, assign) int type;
@property (nonatomic, strong) MHHeaderModel *header;
@property (nonatomic, strong) MHBannerModel *banner;
@property (nonatomic, strong) NSArray<MHItemModel *> *items;

@end
