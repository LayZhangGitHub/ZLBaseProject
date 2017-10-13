//
//  MallItemController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MallItemController.h"

#import "ItemToolBarView.h"

#import "ItemResultModel.h"

#import "ItemRequest.h"

@interface MallItemController ()<ItemToolBarDelegate>

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *cartButton;

@property (nonatomic, strong) ItemToolBarView *itemToolBarView;

@property (nonatomic, strong) ItemInfoModel *itemInfoModel;
@property (nonatomic, strong) ItemRecommendsInfoModel *recommendsInfoModel;
@property (nonatomic, strong) ItemShopInfoModel *shopInfoModel;
@property (nonatomic, strong) ItemCommentsInfoModel *commentsInfoModel;
@property (nonatomic, strong) ShareInfoModel *shareInfoModel;
@property (nonatomic, strong) NSString *cashback;
@property (nonatomic, strong) NSString *quotaDesc;
@property (nonatomic, strong) NSArray *selectedSkus;

@end

@implementation MallItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
//    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    shareButton.frame = CGRectMake(0, 0, 40, 20);
//    [shareButton setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
//    [shareButton addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationBar.rightButton = shareButton;
//    self.shareButton = shareButton;
//    
//    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cartButton.frame = CGRectMake(0, 0, 40, 20);
//    [cartButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
//    [cartButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
//    [cartButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationBar.rightDesButton = cartButton;
//    self.cartButton = cartButton;
//    
//    self.contentTableView.height = SCREENHEIGHT - NAVBARHEIGHT;
//    
//    [self initData];
}

- (void)initData {
    [self loadData];
}

#pragma mark - properties
- (ItemToolBarView *)itemToolBarView {
    if (!_itemToolBarView) {
        _itemToolBarView = [[ItemToolBarView alloc] init];
        _itemToolBarView.frame = CGRectMake(0, SCREENHEIGHT - 45, SCREENWIDTH, 45);
        _itemToolBarView.delegate = self;
        _itemToolBarView.model = [[ItemToolBarModel alloc] initWithIsFav:NO status:StatusUnderCarriage];
    }
    return _itemToolBarView;
}

#pragma mark - handle action
- (void)handleShareButton {}
- (void)handleShowCartButton {}

#pragma mark - itemToolbar delegate
- (void)chatButtonDidClick {}
- (void)myCollectionButtonDidClick {}
- (void)shopButtonDidClick {}
- (void)addToCartButtonDidClick {}
- (void)buyButtonDidClick {}

#pragma mark - dataload
- (void)loadData {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    //self.itemId = @"2558";
    //self.itemId = @"2561";
    params[@"itemId"] = self.itemId;
    
    [ItemRequest getItemDataWithParams:params success:^(ItemResultModel *resultModel) {
        
        if (resultModel) {
            self.itemInfoModel = resultModel.itemInfo;
            self.shopInfoModel = resultModel.shopInfo;
            self.commentsInfoModel = resultModel.commentInfo;
            self.shareInfoModel = resultModel.share;
            self.recommendsInfoModel = resultModel.recommend;
            self.cashback = resultModel.cashback;
            self.quotaDesc = resultModel.quotaDesc;
            self.itemInfoModel.servicePrice = resultModel.serviceCharge;
            NSMutableArray *skus = [NSMutableArray array];
            for (ItemPropertyModel *property in self.itemInfoModel.skuInfo.properties) {
                [skus addObject:@{property.propertyName:@""}];
            }
            self.selectedSkus = skus;
            
            if (self.shareInfoModel) {
                self.navigationBar.rightButton = self.shareButton;
                self.navigationBar.rightDesButton = self.cartButton;
            }else{
                self.navigationBar.rightButton = self.cartButton;
                self.navigationBar.rightDesButton = nil;
            }
        }
        
        //        [self hideErrorTips];
//        [self finishRefresh];
        [self didRefresh];
        
        //        [self.view addSubview:self.toolbarView];
        if ([self.itemInfoModel.type isEqualToString:@"1"]) {
//            [self.view addSubview:self.pointToolBarView];
        }else {
            [self.view addSubview:self.itemToolBarView];
        }
        
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        
        //        [self showErrorTips];
        [self showNotice:status.msg];
        [self didRefresh];
        [self reloadData];
    }];
    
}

@end
