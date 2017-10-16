//
//  PointToolBarView.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLMyBaseView.h"

@protocol PointToolbarDelegate;

@interface PointToolBarView : ZLMyBaseView

@property (nonatomic, weak) id<PointToolbarDelegate> delegate;

@end

@protocol PointToolbarDelegate <NSObject>

- (void)buyButtonDidClick;

@end
