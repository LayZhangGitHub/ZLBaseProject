//
//  PMCategoryResultModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMItemModel.h"

@interface PMCategoryResultModel : NSObject

@property (nonatomic,strong) NSArray<PMItemModel *> *list;
@property (nonatomic,copy) NSString *wp;
@property (nonatomic,assign) BOOL isEnd;
@property (nonatomic,copy) NSString *title;

@end
