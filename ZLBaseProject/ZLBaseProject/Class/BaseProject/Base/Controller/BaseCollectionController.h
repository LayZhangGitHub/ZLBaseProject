//
//  BaseCollectionController.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ScrollableController.h"

typedef NS_ENUM(NSInteger, ScrollViewRefreshType) {
    ScrollViewRefreshTypeNone               = 1 << 0,
    ScrollViewRefreshTypeHeader             = 1 << 1,
    ScrollViewRefreshTypeFooter             = 1 << 2,
};

@interface BaseCollectionController : ScrollableController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) ScrollViewRefreshType scrollViewRefreshType;
@property (nonatomic, strong) UICollectionView *contentCollectionView;

// 需要子类 实现  重写layout
- (void)addCollectionView;
- (void)reloadData;

- (void)couldScrollToFooter:(BOOL)couldScrollToFooter;

@end
