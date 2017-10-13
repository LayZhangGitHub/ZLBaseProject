//
//  MHResultModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareInfoModel.h"
#import "MHModuleModel.h"

@interface MHResultModel : NSObject

@property (nonatomic, strong) NSArray<MHModuleModel *> *list;
@property (nonatomic,strong) ShareInfoModel *share;

@end
