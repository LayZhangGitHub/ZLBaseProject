//
//  MHHeaderModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MHHeaderBarModel.h"
#import "MHHeaderTitleModel.h"
#import "MHHeaderMoreModel.h"

@interface MHHeaderModel : NSObject
@property (nonatomic, strong) MHHeaderBarModel *bar;
@property (nonatomic, strong) MHHeaderTitleModel *title;
@property (nonatomic, strong) MHHeaderMoreModel *more;
@end
