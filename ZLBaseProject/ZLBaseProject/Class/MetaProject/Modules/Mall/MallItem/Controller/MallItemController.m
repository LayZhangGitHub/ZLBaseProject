//
//  MallItemController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MallItemController.h"

@interface MallItemController ()

@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation MallItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 40, 20);
    [shareButton setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightButton = shareButton;
    self.shareButton = shareButton;
}


#pragma mark - handle action
- (void)handleShareButton {}



@end
