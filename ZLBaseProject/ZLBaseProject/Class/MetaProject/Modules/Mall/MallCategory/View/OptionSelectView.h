//
//  OptionSelectView.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLMyBaseView.h"

@protocol OptionSelectView;

@interface OptionSelectView : ZLMyBaseView <NSCopying>

@property (nonatomic, strong) NSArray *arrayModel;
@property (nonatomic, weak) id<OptionSelectView> delegate;

@property (nonatomic,assign) NSInteger initIndex;

@end

@protocol OptionSelectView <NSObject>
- (void)optionChooseIndex:(NSInteger)index
                  keyName:(NSString *)name
                 keyValue:(NSString *)keyValue;
@end
