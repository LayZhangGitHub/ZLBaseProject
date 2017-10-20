//
//  ShopInfoController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopInfoController.h"

#import "ShopRequest.h"

#import "BaseCollectionCell.h"
#import "ShopHeadCell.h"
#import "ShopRestrictionTipCell.h"
#import "ShopSiftCell.h"
#import "ShopCategoryCell.h"
#import "ShopListItemCell.h"

@interface ShopInfoController ()<ShopHeadCellDelegate, ShopSiftCellDelaget, ShopCategoryCellDelegate>

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) NSMutableArray<ShopItemModel *> *items;
@property (nonatomic, strong) ShopInfoModel *shopInfoModel;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) ShopTabModel *currentTab;
@property (nonatomic, strong) NSString *itemTemplate; // item cell 模版

@end

@implementation ShopInfoController

- (void)viewDidLoad {
    self.scrollViewRefreshType = ScrollViewRefreshTypeFooter;
    [super viewDidLoad];
    self.view.backgroundColor = ZLGray(245);
    [self showNavigationBar];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 40, 20);
    [shareButton setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightButton = shareButton;
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 40, 20);
    [infoButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightDesButton = infoButton;
    
    self.navigationBar.middleView = self.searchTextField;
    
    [self initData];
}

- (void)initData {
    self.groups = [NSMutableArray new];
    self.items = [NSMutableArray new];
    [self loadData];
}

- (void)registCell {
    [self.contentCollectionView registerClass:[ShopHeadCell class] forCellWithReuseIdentifier:[ShopHeadCell cellIdentifier]];
    [self.contentCollectionView registerClass:[ShopSiftCell class] forCellWithReuseIdentifier:[ShopSiftCell cellIdentifier]];
    [self.contentCollectionView registerClass:[ShopCategoryCell class] forCellWithReuseIdentifier:[ShopCategoryCell cellIdentifier]];
    
    [self.contentCollectionView registerClass:[ShopListItemCell class] forCellWithReuseIdentifier:[ShopListItemCell cellIdentifier]];
    //    [self.collectionView registerClass:[ShopWallItemCell class] forCellWithReuseIdentifier:[ShopWallItemCell cellIdentifier]];
    //    [self.collectionView registerClass:[ShopListItemCell class] forCellWithReuseIdentifier:[ShopListItemCell cellIdentifier]];
    //    [self.collectionView registerClass:[ShopBannerItemCell class] forCellWithReuseIdentifier:[ShopBannerItemCell cellIdentifier]];
    //    [self.collectionView registerClass:[ShopTopicItemCell class] forCellWithReuseIdentifier:[ShopTopicItemCell cellIdentifier]];
    //    [self.collectionView registerClass:[ShopItemHeaderCell class] forCellWithReuseIdentifier:[ShopItemHeaderCell cellIdentifier]];
    [self.contentCollectionView registerClass:[ShopRestrictionTipCell class]
                   forCellWithReuseIdentifier:[ShopRestrictionTipCell cellIdentifier]];
    
    [self.contentCollectionView registerClass:[BaseCollectionCell class]
                   forCellWithReuseIdentifier:[BaseCollectionCell cellIdentifier]];
}

#pragma mark - collection delegate

- (NSInteger)headerSectionCount {
    return 1;
}

- (NSInteger)itemSectionCount {
    return self.groups.count;
}

- (NSInteger)itemCountInSection:(NSInteger)section {
    NSArray *items = self.groups[section];
    return items.count;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ShopHeadCell *cell = [ShopHeadCell dequeueCellForCollection:self.contentCollectionView
                                                       forIndexPath:indexPath];
        cell.cellData = self.shopInfoModel;
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 1) {
        ShopRestrictionTipCell *cell = [ShopRestrictionTipCell dequeueCellForCollection:self.contentCollectionView
                                                                           forIndexPath:indexPath];
        cell.cellData = self.shopInfoModel.quota;
        return cell;
        
    }else if (indexPath.row == 2) {
        ShopSiftCell *cell = [ShopSiftCell dequeueCellForCollection:self.contentCollectionView
                                                       forIndexPath:indexPath];
        cell.cellData = self.tabs;
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 3) {
        ShopCategoryCell *cell = [ShopCategoryCell dequeueCellForCollection:self.contentCollectionView
                                                               forIndexPath:indexPath];
        cell.cellData = self.currentTab.list;
        cell.delegate = self;
        return cell;
    }
    
    BaseCollectionCell *cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                               forIndexPath:indexPath];
    return cell;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = self.groups[indexPath.section - [self headerSectionCount]];
    //
    ShopItemModel *shopItem = items[indexPath.item];
    if (shopItem.content) {
        ShopItemCell *cell = nil;
        if ([self.itemTemplate isEqualToString:@"1"]) {
            cell = [ShopListItemCell dequeueCellForCollection:self.contentCollectionView
                                                 forIndexPath:indexPath];
        }else if ([self.itemTemplate isEqualToString:@"2"]||[self.itemTemplate isEqualToString:@"5"]) {
//            cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopWallItemCell cellIdentifier] forIndexPath:indexPath];
            
        }else if ([self.itemTemplate isEqualToString:@"3"]) {
//            cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopTopicItemCell cellIdentifier] forIndexPath:indexPath];
            
        }else if ([self.itemTemplate isEqualToString:@"4"]) {
//            cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopBannerItemCell cellIdentifier] forIndexPath:indexPath];
        }
        cell.cellData = shopItem.content;
        cell.delegate = self;
        return cell;
    }else{
//        ShopItemHeaderCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopItemHeaderCell cellIdentifier] forIndexPath:indexPath];
//        cell.cellData = wallItem.head;
//        [cell reloadData];
//        return cell;
    }
    BaseCollectionCell *cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                               forIndexPath:indexPath];
    return cell;
}

- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (indexPath.row == 0) {
        height = [[ShopHeadCell heightForCell:self.shopInfoModel] floatValue];
    }else if (indexPath.row == 1) {
        height = [[ShopRestrictionTipCell heightForCell:self.shopInfoModel.quota] floatValue];
    }
    else if (indexPath.row == 2){
        height = [[ShopSiftCell heightForCell:self.tabs] floatValue];
    }else{
        height = [[ShopCategoryCell heightForCell:self.currentTab.list] floatValue];
    }
    return CGSizeMake(SCREENWIDTH, height);
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        NSArray *items = self.groups[indexPath.section - [self headerSectionCount]];
    
        ShopItemModel *shopItem = items[indexPath.item];
        CGFloat height = 0;
        CGFloat width = 0;
    
        if (shopItem.content) {
            if ([self.itemTemplate isEqualToString:@"1"]) {
                height = [[ShopListItemCell heightForCell:shopItem.content] floatValue];
                width = [[ShopListItemCell widthForCell:shopItem.content] floatValue];
            }else if ([self.itemTemplate isEqualToString:@"2"]||[self.itemTemplate isEqualToString:@"5"]) {
//                height = [ShopWallItemCell heightForCell:wallItem.content];
    
            }else if ([self.itemTemplate isEqualToString:@"3"]) {
//                height = [ShopTopicItemCell heightForCell:wallItem.content];
//                width = SCREEN_WIDTH;
            }else if ([self.itemTemplate isEqualToString:@"4"]) {
//                height = [ShopBannerItemCell heightForCell:wallItem.content];
//                width = BANNER_WIDTH;
            }
    
        }else{
//            height = [ShopItemHeaderCell heightForCell:wallItem.head];
//            width = SCREEN_WIDTH;
        }
    return CGSizeMake(width, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(InstViewLayout *)layout numberOfColumnsInSection:(NSInteger)section {
    if ([self headerSectionCount] > section) {
        return 1;
    }
    NSArray *items = self.groups[section - [self headerSectionCount]];
    ShopItemModel *item = items[0];
    if (item.head) {
        return 1;
    }else{
        if ([self.itemTemplate isEqualToString:@"2"]||[self.itemTemplate isEqualToString:@"5"]) {
            return 2;
        }
        return 1;
    }
    return 1;
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = self.groups[indexPath.section - [self headerSectionCount]];
    ShopItemModel *shopItem = items[indexPath.item];
    if (shopItem.content) {
        ShopItemCell *cell = (ShopItemCell *)[self.contentCollectionView cellForItemAtIndexPath:indexPath];
        if (cell.showMask) {
            [cell hideMaskAnimated];
        }else{
            [[ZLNavigationService sharedService] openUrl:shopItem.content.link];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self headerSectionCount] > section) {
        if (section == 0) {
            return 4;
        } else {
            return 0;
        }
    }
    return [self itemCountInSection:section - [self headerSectionCount]];
}


- (void)groupsFromItems:(NSArray*)items {
    [self.groups removeAllObjects];
    for (ShopItemModel *shop in items) {
        if (shop.head) {
            [self.groups addObject:[NSMutableArray array]];
        }
        NSMutableArray *array = [self.groups lastObject];
        if (!array) {
            array = [NSMutableArray array];
            [self.groups addObject:array];
        }
        [array addObject:shop];
    }
}

#pragma mark - properties

- (UITextField*)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.size = CGSizeMake(SCREENWIDTH, 30);
        _searchTextField.font = ZLNormalFont(14);
        _searchTextField.placeholder = @"搜索商品、品牌";
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.backgroundColor = ZLGray(240);
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.layer.cornerRadius = 2.;
        _searchTextField.layer.masksToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        imageView.image = [UIImage imageNamed:@"search_icon_search"];
        imageView.centerY = 15;
        imageView.centerX = 15;
        UIView *bkg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [bkg addSubview:imageView];
        _searchTextField.leftView = bkg;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *mask = [[UIView alloc]initWithFrame:_searchTextField.bounds];
        [_searchTextField addSubview:mask];
        [mask bk_whenTapped:^{
            [self handleSearchButton];
        }];
    }
    return _searchTextField;
}

#pragma mark - event handle
- (void)handleShareButton {}
- (void)handleShowCartButton {}
- (void)handleSearchButton {}


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
    [self doLoadMore];
}

- (void)loadData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    params[@"shopId"] = self.shopId;
    params[@"type"] = self.type;
    params[@"categoryId"] = self.categoryId;
    
    [ShopRequest getShopDataWithParams:params success:^(ShopInfoResultModel *resultModel) {
        [self.items removeAllObjects];
        
        if ( resultModel && resultModel.items ) {
            
            [self.items addObjectsFromArray:resultModel.items.list];
            [self groupsFromItems:self.items];
            self.itemTemplate = resultModel.items.template;
            self.tabs = resultModel.tab;
            
            //            if ([self.itemTemplate isEqualToString:@"1"]|| [self.itemTemplate isEqualToString:@"3"]) {
            //                self.view.backgroundColor = Color_White;
            //            }else{
            //                self.view.backgroundColor = Color_Gray245;
            //            }
            
            for (ShopTabModel *tab in self.tabs) {
                if (tab.isSelected) {
                    self.currentTab = tab;
                    self.type = tab.type;
                    for (ShopTabCateModel *cate in tab.list) {
                        if (cate.isSelected) {
                            self.categoryId = cate.value;
                        }
                    }
                }
            }
        }
        
        self.wp = resultModel.items.wp;
        
        [self couldScrollToFooter:!resultModel.items.isEnd];
        
        self.shopInfoModel = resultModel.shopInfo;
        self.shopInfoModel.quota = @"111111111";
        //            self.shareInfo = resultModel.share;
        //            if (self.shareInfo) {
        //                self.shareButton.hidden = NO;
        //                self.shareButton.right = SCREEN_WIDTH - 12;
        //                self.shareButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
        //
        //                self.cartButton.right = self.shareButton.left ;
        //                self.cartButton.centerY = self.shareButton.centerY;
        //                self.searchTextField.width =  SCREEN_WIDTH - 40 - 56-40;
        //            }else{
        //                self.shareButton.hidden = YES;
        //
        //                self.cartButton.right = SCREEN_WIDTH - 12;
        //                self.cartButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
        //                self.searchTextField.width =  SCREEN_WIDTH - 40 - 56;
        //            }
        //            if ( IsEmptyString(self.shopInfo.shopId) ) {
        //                self.shopInfo.shopId = self.shopId;
        //            }
        
        [self didRefresh];
        
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
        [self didRefresh];
        [self reloadData];
    }];
}

- (void)doLoadMore {
    [super doLoadMore];
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    //
    //    params[@"wp"] = self.wp;
    //
    //    [SiftCateRequest getMCCategoryDataWithParams:params success:^(TMCateSiftResultModel *resultModel) {
    //
    //        if (resultModel && resultModel.items) {
    //            [self.items addObjectsFromArray:resultModel.items.list];
    //
    //            self.wp = resultModel.items.wp;
    //            [self couldScrollToFooter:!resultModel.items.isEnd];
    //        }
    //
    //        [self didLoadMore];
    //        [self reloadData];
    //    } failure:^(StatusModel *status) {
    //        [self showNotice:status.msg];
    //        [self didLoadMore];
    //        [self reloadData];
    //    }];
}

#pragma mark - shopheader delegate
- (void)addFavShop:(UIButton *)sender {
    sender.enabled = NO;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    params[@"shopId"] = self.shopId;
    
    [ShopRequest followWithParams:params success:^(ShopFavResultModel *resultModel) {
        sender.enabled = YES;
        [self showNotice:@"收藏成功"];
        
        self.shopInfoModel.isFav = YES;
        self.shopInfoModel.favCount = resultModel.favCount;
        
        [self reloadData];
    } failure:^(StatusModel *status) {
        sender.enabled = YES;
        [self showNotice:status.msg];
    }];
}

- (void)cancelFavShop:(UIButton *)sender {
    sender.enabled = NO;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    params[@"shopId"] = self.shopId;
    
    [ShopRequest unfollowWithParams:params success:^(ShopFavResultModel *resultModel) {
        sender.enabled = YES;
        [self showNotice:@"取消收藏成功"];
        self.shopInfoModel.isFav = NO;
        self.shopInfoModel.favCount = resultModel.favCount;
        
        [self reloadData];
    } failure:^(StatusModel *status) {
        sender.enabled = YES;
        [self showNotice:status.msg];
    }];
}

#pragma mark - shop cell sift delegate
- (void)cellTapSift:(id)model {
    ShopTabModel *tab = (ShopTabModel*)model;
    self.type = tab.type;
    self.categoryId = nil;
    [self initData];
}

#pragma mark - shop cate delegate
- (void)cellTapCate:(id)model {
    ShopTabCateModel *cate = (ShopTabCateModel*)model;
    self.categoryId = cate.value;
    [self initData];
}

@end
