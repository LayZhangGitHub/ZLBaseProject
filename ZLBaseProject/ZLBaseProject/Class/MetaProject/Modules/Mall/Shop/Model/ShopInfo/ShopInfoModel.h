//
//  ShopInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopInfoModel : NSObject

@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, strong) NSString *favCount;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, assign) CGFloat ar;
@property (nonatomic,strong) NSString *quota; // 描述 // 限额多少、

@end
