//
//  ItemCommentsInfoModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/13.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ItemCommentModel.h"

@interface ItemCommentsInfoModel : NSObject

@property (nonatomic, strong) NSString *cmtCount;
@property (nonatomic, strong) NSArray<ItemCommentModel *> *comments;
@property (nonatomic, strong) NSString *link;

@end
