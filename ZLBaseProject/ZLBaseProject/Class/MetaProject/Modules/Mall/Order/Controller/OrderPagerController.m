//
//  OrderPagerController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "OrderPagerController.h"
#import "OrderListController.h"

#define DefaultSelectIndex -1

@interface OrderPagerController ()<ZLPagerDelegate>

@property (nonatomic, strong) NSArray *tabNames;
@property (nonatomic, strong) NSArray *status;

@end

@implementation OrderPagerController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self showNavigationBar];
    
    self.choosedColor = ZLRedColor;
    self.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.noScroll = YES;
    self.noSelectBold = YES;
    
    self.title = @"订单列表";
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (DefaultSelectIndex != self.selectedIndex) {
        [self selectTabAtIndex:self.selectedIndex];
        self.selectedIndex = DefaultSelectIndex;
    }
}


- (void)initData {
    [self loadData];
}

- (void)loadData {
    // 客户端写死， 也可以从后台拿
    self.tabNames = @[@"全部", @"待付款",@"待发货", @"待收货", @"待评价"];
    self.status = @[@"0", @"1", @"2", @"3",@"4"];
    [self reloadData];
}

#pragma mark - TTViewPagerDelegate
- (NSUInteger)numberOfTabsForViewPager:(ZLPagerController *)viewPager {
    return self.tabNames.count;
}

- (UILabel *)viewPager:(ZLPagerController *)viewPager tabForTabAtIndex:(NSUInteger)index {
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = ZLGray(153);
    titleLabel.font = ZLNormalFont(14);
    titleLabel.text = self.tabNames[index];
    [titleLabel sizeToFit];
    return titleLabel;
}

- (UIViewController *)viewPager:(ZLPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    OrderListController *contentVC = [[OrderListController alloc] init];
    contentVC.type = self.type;
    contentVC.status = self.status[index];
    
    return contentVC;
}

#pragma mark - TTErrorTipsViewDelegate
- (void)failedViewBeginReload:(ZLFailedAndReloadView *)reloadView {
    NSLog(@"reoload data here!!!");
    [self loadData];
}

@end
