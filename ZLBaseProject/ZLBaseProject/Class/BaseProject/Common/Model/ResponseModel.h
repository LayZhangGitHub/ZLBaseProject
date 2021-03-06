//
//  ResponseModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusModel.h"

@interface ResponseModel : NSObject

@property (nonatomic, strong) StatusModel *status;
@property (nonatomic, strong) NSDictionary *result;

@end
