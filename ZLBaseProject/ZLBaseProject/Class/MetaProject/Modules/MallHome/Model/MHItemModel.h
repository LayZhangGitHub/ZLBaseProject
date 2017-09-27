//
//  MHItemModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHItemModel : NSObject

@property (nonatomic, assign) float ar;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *link;

@end
