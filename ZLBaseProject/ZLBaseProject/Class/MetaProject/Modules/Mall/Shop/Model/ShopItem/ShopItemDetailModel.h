//
//  ShopItemDetailModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopItemDetailModel : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) CGFloat ar;
@property (nonatomic, assign) BOOL isFav;

@end
