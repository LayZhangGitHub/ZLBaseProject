//
//  BaseCollectionController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseCollectionController.h"
#import "BaseCollectionCell.h"
#import "MJRefresh.h"

@interface BaseCollectionController ()

@end

@implementation BaseCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCollectionView];
    [self addRefreshAction];
}

#pragma mark - component
- (void)addCollectionView {
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    
    CGFloat top = self.isHideNavigationBar ? 0 : NAVBARHEIGHT;
    
    self.contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, top, SCREENWIDTH, SCREENHEIGHT - top) collectionViewLayout:layout];
    
    self.contentCollectionView.delegate = self;
    self.contentCollectionView.dataSource = self;
    self.contentCollectionView.backgroundColor = [UIColor clearColor];
    
    [self registCell];
    
    [self.view addSubview:self.contentCollectionView];
}

#pragma mark - abstract methods

- (void)registCell {
    
}

- (void)addRefreshAction {
    weakSelf(self);
    self.contentCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        strongSelf(self);
        [self willRefresh];
    }];
    
    self.contentCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        strongSelf(self);
        [self willLoadMore];
    }];
}

- (void)reloadData {
    if (self.contentCollectionView) {
        [self.contentCollectionView reloadData];
    }
}


- (void)willRefresh {
    [super willRefresh];
}

- (void)doRefresh {
    [super doRefresh];
}

- (void)didRefresh {
    [super didRefresh];
    [self.contentCollectionView.mj_header endRefreshing];
}

- (void)willLoadMore {
    [super willLoadMore];
}

- (void)doLoadMore {
    [super doLoadMore];
}

- (void)didLoadMore {
    [super didLoadMore];
    [self.contentCollectionView.mj_footer endRefreshing];
}




@end
