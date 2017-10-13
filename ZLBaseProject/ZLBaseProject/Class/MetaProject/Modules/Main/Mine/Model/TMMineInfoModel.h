//
//  TMMineInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMMineOrderModel.h"

@interface TMMineInfoModel : NSObject

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *aboutLink;
@property (nonatomic, strong) NSString *coins;
@property (nonatomic, strong) NSString *supportLink;
@property (nonatomic, strong) NSString *protocolLink;
@property (nonatomic, strong) NSString *representLink;
@property (nonatomic, strong) TMMineOrderModel *orderPendingCount;
@property (nonatomic, assign) BOOL showLuck;
@property (nonatomic, strong) NSString *address;

@end
