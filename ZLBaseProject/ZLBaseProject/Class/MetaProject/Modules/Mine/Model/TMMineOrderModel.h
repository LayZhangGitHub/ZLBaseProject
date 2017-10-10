//
//  TMMineOrderModel.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMMineOrderModel : NSObject

@property (nonatomic, strong) NSString *unpaid;
@property (nonatomic, strong) NSString *unShipping;
@property (nonatomic, strong) NSString *unReceived;
@property (nonatomic, strong) NSString *unEvaluated;
@property (nonatomic, strong) NSString *saleAfter;

@end
