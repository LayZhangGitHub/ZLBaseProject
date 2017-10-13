//
//  OrderListController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "OrderListController.h"

@interface OrderListController ()

@end

@implementation OrderListController

- (void)viewDidLoad {
    
    self.isHideNavigationBar = YES;
    [super viewDidLoad];
    
    self.view.backgroundColor = ZLGray(245);
    
    self.contentTableView.top = 0;
    self.contentTableView.height = SCREENHEIGHT - TABSVIEWHEIGHT - NAVBARHEIGHT;
    
    //
    self.contentTableView.backgroundColor = [UIColor greenColor];
}

@end
