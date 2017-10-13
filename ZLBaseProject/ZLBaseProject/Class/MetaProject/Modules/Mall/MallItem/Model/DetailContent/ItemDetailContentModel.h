//
//  ItemDetailContentModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 商品 详情 介绍
 */
@interface ItemDetailContentModel : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) CGFloat  ar;

@end
