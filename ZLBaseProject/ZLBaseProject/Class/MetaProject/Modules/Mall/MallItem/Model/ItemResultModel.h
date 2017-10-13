//
//  ItemResultModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemCommentsInfoModel.h"
#import "ItemShopInfoModel.h"
#import "ShareInfoModel.h"
#import "ItemRecommendsInfoModel.h"
#import "ItemInfoModel.h"

@interface ItemResultModel : NSObject

@property (nonatomic, strong) ItemInfoModel *itemInfo;
@property (nonatomic, strong) ItemShopInfoModel *shopInfo;
@property (nonatomic, strong) ItemCommentsInfoModel *commentInfo;
@property (nonatomic, strong) ShareInfoModel *share;
@property (nonatomic, strong) ItemRecommendsInfoModel *recommend;
@property (nonatomic,copy) NSString *serviceCharge;
@property (nonatomic,copy) NSString *cashback;
@property (nonatomic,copy) NSString *quotaDesc;

@end
