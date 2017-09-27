//
//  MallHomeController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MallHomeController.h"
#import "MallHomeRequest.h"
#import "MHResultModel.h"

@interface MallHomeController ()

@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *cartButton;

// request model
@property (nonatomic, strong) MHResultModel *resultModel;
@property (nonatomic, strong) NSMutableArray *items;


@end

@implementation MallHomeController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[ZLTabbarItem alloc] initWithTitle:@"淘梦商城"
                                                   titleColor:ZLGray(135)
                                           selectedTitleColor:ZLRedColor
                                                         icon:[UIImage imageNamed:@"icon_tabbar_home_normal"]
                                                 selectedIcon:[UIImage imageNamed:@"icon_tabbar_home_select"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZLGray(245);
    [self showNavigationBar];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 40, 20);
    [shareButton setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
    shareButton.right = SCREENWIDTH - 12;
    shareButton.centerY = (STATUSBARHEIGHT + self.navigationBar.height)/2;
    [self.navigationBar addSubview:shareButton];
    shareButton.hidden = NO;
    self.shareButton = shareButton;
    
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 40, 20);
    [infoButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    infoButton.right = SCREENWIDTH - 12;
    infoButton.centerY = (STATUSBARHEIGHT + self.navigationBar.height)/2;
    [self.navigationBar addSubview:infoButton];
    self.cartButton = infoButton;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(handleSearchButton) forControlEvents:UIControlEventTouchUpInside];
    leftButton.left = 8;
    leftButton.centerY = (STATUSBARHEIGHT + self.navigationBar.height)/2;
    [self.navigationBar addSubview:leftButton];
    
    self.contentCollectionView.height = SCREENHEIGHT - NAVBARHEIGHT - TABBARHEIGHT;
    //    self.contentCollectionView.showsInfiniteScrolling = NO;
    self.contentCollectionView.alwaysBounceVertical = YES;
    
    self.hasHeader = YES;
    
    self.title = @"淘梦商城";
    [self initData];
    //    [[VersionCheckService sharedService] check];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(launchViewWillRemove:) name:LaunchViewWillRemoveNotification object:nil];
}

#pragma mark - private method
- (void)handleShareButton {
    ZLFileLog();
    //    if (!self.shareInfo) {
    //        [self showNotice:@"分享信息获取失败，请稍后再试"];
    //        return;
    //    }
    //    self.shareView.shareInfo = self.shareInfo;
    //    [self.shareView show];
}

- (void) handleShowCartButton {
    
    //    [[ZLNavigationService sharedService] openUrl:LOCALSCHEMA(@"mallCart")];
    //[[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"luckDraw")];
    
}

- (void)handleSearchButton {
    //    [[ZLNavigationService sharedService] openUrl:LOCALSCHEMA(@"search")];
}


- (void)initData {
    self.items = [NSMutableArray array];
    //    self.loadingType = kInit;
    [self loadData];
}


- (void)loadData {
    /**
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    
    [MallHomeRequest getHomeDataWithParams:params success:^(MHResultModel *resultModel) {
        //[self hideErrorTips];
        
        [self.items removeAllObjects];
        self.resultModel = resultModel;
        [self.items addObjectsFromArray:resultModel.list];
        //        self.shareInfo = resultModel.share;
        //        self.collectionView.showsInfiniteScrolling = NO;
        //        [self finishRefresh];
        [self reloadData];
        //        self.lastRefresh = YES;
        //        [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_APP_LAUNCH_REMOVE object:nil];
        if (self.resultModel.share) {
            self.shareButton.hidden = NO;
            self.shareButton.right = SCREENWIDTH - 12;
            self.shareButton.centerY = (STATUSBARHEIGHT + self.navigationBar.height)/2;
            
            self.cartButton.right = self.shareButton.left ;
            self.cartButton.centerY = self.shareButton.centerY;
        }else{
            self.shareButton.hidden = YES;
            
            self.cartButton.right = SCREENWIDTH - 12;
            self.cartButton.centerY = (STATUSBARHEIGHT + self.navigationBar.height)/2;
        }
        
        
    } failure:^(StatusModel *status) {
        //        [self hideErrorTips];
        //        [self showNotice:status.msg];
        //        [self finishRefresh];
        //        [self reloadData];
        //        [self showErrorTips];
        //        self.lastRefresh = NO;
        //        [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_APP_LAUNCH_REMOVE object:nil];
    }];
     
     **/
}


@end
