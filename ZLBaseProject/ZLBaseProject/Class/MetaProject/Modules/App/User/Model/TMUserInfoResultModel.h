//
//  TMUserInfoResultModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMUserInfoModel.h"

@interface TMUserInfoResultModel : NSObject

@property (nonatomic, strong) TMUserInfoModel *user;
@property (nonatomic, strong) NSString *tip;

@end
