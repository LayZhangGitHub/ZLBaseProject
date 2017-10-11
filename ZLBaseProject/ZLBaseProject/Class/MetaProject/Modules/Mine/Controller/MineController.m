//
//  MineController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MineController.h"
#import "TMMineInfoModel.h"

#import "MineRequest.h"
#import "UserInfoService.h"

#import "BaseTableCell.h"
#import "MineHeaderCell.h"
#import "MineOrderCell.h"
#import "MineMenuCell.h"

static NSInteger const sectionUser = 0;
static NSInteger const sectionMenu = 1;

@interface MineController ()

@property (nonatomic, strong) NSMutableArray *menu;

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) TMMineInfoModel *resultModel;

@end

@implementation MineController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[ZLTabbarItem alloc] initWithTitle:@"我的"
                                                   titleColor:ZLGray(153)
                                           selectedTitleColor:ZLRedColor
                                                         icon:[UIImage imageNamed:@"icon_tabbar_mine_normal"]
                                                 selectedIcon:[UIImage imageNamed:@"icon_tabbar_mine_selected"]];
    }
    return self;
}

- (void)viewDidLoad {
    self.scrollViewRefreshType = ScrollViewRefreshTypeNone;
    [super viewDidLoad];
    
    [self showNavigationBar];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 32);
    rightButton.titleLabel.font = ZLNormalFont(18);
    [rightButton setImage:[UIImage imageNamed:@"mine_setting_icon"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(handleSetting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightButton = rightButton;
    
    self.view.backgroundColor = ZLGray(245);
    
    self.contentTableView.height = SCREENHEIGHT - NAVBARHEIGHT - TABBARHEIGHT;
    self.title = @"我的";
    
    [DefaultNotificationCenter addObserver:self selector:@selector(initData)
                                      name:kNotificationUserLogin object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(initData)
                                      name:kNotificationUserLogout object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}

- (void)initData {
    [self loadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == sectionUser) {
        return 4;
    } else if (section == sectionMenu) {
        return self.menu.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == sectionUser) {
        if (0 == indexPath.row){
            MineHeaderCell *cell = [MineHeaderCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel;
            return cell;
        } else if (2 == indexPath.row) {
            MineOrderCell *cell = [MineOrderCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.orderPendingCount;
            return cell;
        }
        
    } else if (indexPath.section == sectionMenu) {
        if (indexPath.row < self.menu.count) {
            NSDictionary *itemData = self.menu[indexPath.row];
            
            if ( ![@"empty" isEqualToString:itemData[@"type"]]) {
                MineMenuCell *cell = [MineMenuCell dequeueReusableCellForTableView:tableView];
                cell.cellData = itemData;
                return cell;
            }
        }
    }
    
    BaseTableCell *cell = [BaseTableCell dequeueReusableCellForTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    
    if (indexPath.section == sectionUser) {
        
        if (0 == indexPath.row){
            height = [[MineHeaderCell heightForCell:nil] floatValue];
        } else if (2 == indexPath.row) {
            height = [[MineOrderCell heightForCell:nil] floatValue];
        } else {
            height = 14;
        }
        
    }  else if (indexPath.section == sectionMenu) {
        if ( indexPath.row < self.menu.count ) {
            height = [[MineMenuCell heightForCell:self.menu[indexPath.row]] floatValue];
        }
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == sectionMenu) {
        if (indexPath.row < self.menu.count) {
            NSDictionary *itemData = self.menu[indexPath.row];
            
            if ( [@"item" isEqualToString:itemData[@"type"]]) {
                [[ZLNavigationService sharedService] openUrl:itemData[@"link"]];
            }
        }
    }
}

#pragma mark - handle action
- (void)handleSetting {
    
}

#pragma mark - failed and reload deleaget
- (void)failedViewBeginReload:(ZLFailedAndReloadView *)reloadView {
    NSLog(@"reoload data here!!!");
    [self loadData];
}



#pragma mark - header and footer refresh
- (void)willRefresh {
    [super willRefresh];
    [self loadData];
}

- (void)willLoadMore {
    [super willLoadMore];
    [self didLoadMore];
}

- (void)loadData {
    // 以后整理
    self.menu = [NSMutableArray arrayWithArray:@[
                  @{@"type":@"empty",},
                  @{@"type":@"item", @"icon":@"icon_mine_cart", @"title":@"购物车", @"link":@"xiaoma://mallCart", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"item", @"icon":@"icon_mine_collection", @"title":@"我的收藏", @"link":@"xiaoma://myCollection", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"item", @"icon":@"icon_mine_point", @"title":@"淘米余额", @"link":@"xiaoma://pointDetail", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"item", @"icon":@"icon_mine_pointorder", @"title":@"淘米商城订单", @"link":@"xiaoma://pointMallOrderList", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"empty",},
                  @{@"type":@"item", @"icon":@"icon_mine_ member", @"title":@"成为会员", @"link":@"", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"item", @"icon":@"icon_mine_ invite", @"title":@"邀请有礼", @"link":@"", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"empty",},
                  //@{@"type":@"item", @"icon":@"icon_mine_lottery", @"title":@"全部夺宝记录", @"link":@"xiaoma://lotteryRecords", @"line":@YES, @"arrow":@YES},
                  //@{@"type":@"item", @"icon":@"icon_mine_lucky", @"title":@"幸运记录", @"link":@"xiaoma://luckRecord", @"line":@YES, @"arrow":@YES},
                  //@{@"type":@"item", @"icon":@"icon_mine_topUp", @"title":@"充值记录", @"link":@"xiaoma://chargeRecords", @"line":@YES, @"arrow":@YES},
                  ]];
    
    [MineRequest getMineDataWithParams:nil success:^(TMMineInfoModel *resultModel) {
        
        if (resultModel) {
            self.resultModel = resultModel;
            self.points = resultModel.points;
            [UserInfoService shareUserInfo].userInfo.gender = resultModel.gender;
            [UserInfoService shareUserInfo].userInfo.name = resultModel.nickName;
            [UserInfoService shareUserInfo].userInfo.avatar = resultModel.avatar;
            
            if ([resultModel.aboutLink isNotEmptyString]) {
                [[NSUserDefaults standardUserDefaults] setObject:resultModel.aboutLink forKey:@"aboutLink"];
            }
            if ([resultModel.supportLink isNotEmptyString]) {
                [[NSUserDefaults standardUserDefaults] setObject:resultModel.supportLink forKey:@"supportLink"];
            }
            if ([resultModel.protocolLink isNotEmptyString]) {
                [[NSUserDefaults standardUserDefaults] setObject:resultModel.protocolLink forKey:@"protocolLink"];
            }
            
            self.menu =
            [NSMutableArray arrayWithArray:@[ @{@"type":@"empty",},
                                              @{@"type":@"item", @"icon":@"icon_mine_location", @"title":@"居住地", @"link":@"", @"line":@YES, @"arrow":@NO,@"value":resultModel.address},
                                              @{@"type":@"item", @"icon":@"icon_mine_cart", @"title":@"购物车", @"link":@"xiaoma://mallCart", @"line":@YES, @"arrow":@YES,@"value":@""},
                                              @{@"type":@"item", @"icon":@"icon_mine_collection", @"title":@"我的收藏", @"link":@"xiaoma://myCollection", @"line":@YES, @"arrow":@YES,@"value":@""},
                                              @{@"type":@"empty",},
                                              @{@"type":@"item", @"icon":@"icon_mine_point", @"title":@"淘米余额", @"link":@"xiaoma://pointDetail", @"line":@YES, @"arrow":@YES,@"value":resultModel.points},
                                              @{@"type":@"item", @"icon":@"icon_mine_pointorder", @"title":@"淘米商城订单", @"link":@"xiaoma://mallOrderList?type=1", @"line":@YES, @"arrow":@YES,@"value":@""},
                                              @{@"type":@"empty",},
                                              @{@"type":@"item", @"icon":@"icon_mine_ member", @"title":@"成为会员", @"link":LocalAppHost(BecomeMemberHost), @"line":@YES, @"arrow":@YES,@"value":@""},
                                              @{@"type":@"item", @"icon":@"icon_mine_ invite", @"title":@"邀请有礼", @"link":resultModel.representLink, @"line":@YES, @"arrow":@YES,@"value":@""},
                                              @{@"type":@"empty",},]];
            if (resultModel.showLuck) {
                [self.menu addObjectsFromArray:@[
                                                 @{@"type":@"item", @"icon":@"icon_mine_lottery", @"title":@"全部夺宝记录", @"link":@"xiaoma://lotteryRecords", @"line":@YES, @"arrow":@YES,@"value":@""},
                                                 @{@"type":@"item", @"icon":@"icon_mine_lucky", @"title":@"幸运记录", @"link":@"xiaoma://luckRecord", @"line":@YES, @"arrow":@YES,@"value":@""},
                                                 @{@"type":@"item", @"icon":@"icon_mine_topUp", @"title":@"充值记录", @"link":@"xiaoma://chargeRecords", @"line":@YES, @"arrow":@YES,@"value":@""},
                                                 @{@"type":@"empty"}]];
            }
        }
        
        [self hideFailedView];
        [self didRefresh];
        
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        
        ZLLog(@"%@", status);
        
        [self didRefresh];
        [self reloadData];
        
    }];
}

- (void)dealloc {
    [DefaultNotificationCenter removeObserver:self];
}

@end
