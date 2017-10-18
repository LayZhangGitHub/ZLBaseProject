//
//  OptionUDView.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLMyBaseView.h"

@interface OptionUDView : ZLMyBaseView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL isShowUD;
@property (nonatomic, assign) BOOL isSelect;

- (BOOL)isOrderUp;

@end
