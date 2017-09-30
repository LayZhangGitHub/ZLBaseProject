//
//  PMItemModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMItemModel : NSObject

@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,assign) CGFloat ar;

@end
