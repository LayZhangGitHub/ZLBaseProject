//
//  ConsigneeSelectController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ConsigneeSelectController.h"

@interface ConsigneeSelectController ()

@end

@implementation ConsigneeSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showNavigationBar];
    self.view.backgroundColor = ZLGray(245);
    
    self.title = @"选择收货地址";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
