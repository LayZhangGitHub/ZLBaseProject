//
//  ItemRecommendModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 推荐
 */
@interface ItemRecommendModel : NSObject

@property (nonatomic, assign) CGFloat ar;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *link;

@end
