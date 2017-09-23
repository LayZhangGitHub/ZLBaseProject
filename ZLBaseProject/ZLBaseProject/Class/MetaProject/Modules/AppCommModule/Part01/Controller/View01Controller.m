//
//  View01Controller.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "View01Controller.h"
#import "ZLTabbarItem.h"
#import "ZLNavigationService.h"

@interface View01Controller ()

@end

@implementation View01Controller

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem =
        [[ZLTabbarItem alloc] initWithTitle:@"淘梦商城"
                                 titleColor:ZLGray(153)
                         selectedTitleColor:ZLThemeCtrInstance.tabbarSelectColor
                                       icon:[UIImage imageNamed:@"icon_tabbar_home_normal"]
                               selectedIcon:[UIImage imageNamed:@"icon_tabbar_home_select"]];
    }
    return self;
}

- (void)viewDidLoad {
    self.isHideNavigationBar = NO;
    [super viewDidLoad];
    [self showNavigationBar];
    [self setTitle:@"title01"];
 
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = ZLGray(9);
    [self.view addSubview:button];
    
    [button addTarget:self
               action:@selector(d)
     forControlEvents:UIControlEventTouchUpInside];
}

- (void)d {
    [[ZLNavigationService sharedService] openUrl:@"xiaoma://login"];
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
