//
//  TMCateSiftModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMCateSiftOptionModel.h"
#import "TMCateSiftKeyModel.h"

@interface TMCateSiftModel : NSObject

@property (nonatomic,strong) TMCateSiftKeyModel *key;
@property (nonatomic,strong) NSArray<TMCateSiftOptionModel *> *options;

@end
