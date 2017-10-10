//
//  BecomeMemberController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BecomeMemberController.h"

#import "TMVipModel.h"

#import "MineRequest.h"

@interface BecomeMemberController ()
//@property (nonatomic,strong) UIButton *buytButton;
@property (nonatomic, strong) TMVipModel *vipModel;

@end

@implementation BecomeMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showNavigationBar];
    self.view.backgroundColor = ZLGray(245);
    
    self.title = @"会员";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData {
    [MineRequest getVipDataWithParams:nil success:^(TMVipModel *resultModel) {
        if (resultModel) {
            self.vipModel = resultModel;
            [self updateView];
        }
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

- (void)initComponent {
}

- (void)updateView {}

#pragma mark - pay
- (void)handleButButton:(UIButton*)button {
    [MineRequest becomeMemberWithParams:nil success:^(NSDictionary *result) {
        if (result) {
            NSString *payId = [NSString stringWithFormat:@"%@",[result objectForKey:@"payId"]];
//            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"cashier?payId=%@&totalPrice=%@&vipPay=vipPay",payId,self.resultModel.price)];
        }
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}



@end
