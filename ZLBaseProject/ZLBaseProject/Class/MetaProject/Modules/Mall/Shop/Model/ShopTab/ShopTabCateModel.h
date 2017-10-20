//
//  ShopTabCateModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 category 次级分类
 */
@interface ShopTabCateModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL isSelected;

@end
