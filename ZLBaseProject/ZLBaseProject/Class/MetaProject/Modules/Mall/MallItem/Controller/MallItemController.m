//
//  MallItemController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MallItemController.h"

#import "BaseTableCell.h"
#import "ItemCoverImageCell.h"
#import "ItemInfoCell.h"
#import "ItemRebateCell.h"
#import "ItemTipsCell.h"
#import "ItemSKUSelectCell.h"
#import "ItemCommentHeadCell.h"
#import "ItemCommentContentCell.h"
#import "ItemCommentFootCell.h"
#import "ItemShopInfoCell.h"
#import "ItemContentHeadCell.h"
#import "ItemContentImageCell.h"
#import "ItemContentTextCell.h"

#import "ItemToolBarView.h"
#import "PointToolBarView.h"

#import "ItemResultModel.h"

#import "ItemRequest.h"

static CGFloat const toolBarHeight = 45.;

typedef NS_ENUM(NSInteger, ItemDetailSection) {
    ItemDetailSectionItem       = 0,
    ItemDetailSectionSKU        = 1,
    ItemDetailSectionComment    = 2,
    ItemDetailSectionShop       = 3,
    ItemDetailSectionImages     = 4,
    ItemDetailSectionRecommend  = 5,
    ItemDetailSectionEmpty      = 6,
};

typedef NS_ENUM(NSInteger, ItemDetailRow) {
    ItemDetailRowImage  = 0,
    ItemDetailRowInfo   = 1,
    ItemDetailRowRule   = 2,
    ItemDetailRowTip    = 4,
};

const NSInteger itemDetailSKURowInfo        = 0;
const NSInteger itemDetailCommentRowHead    = 0;
const NSInteger itemDetailShopRowInfo       = 0;
const NSInteger itemDetailContentRowHead    = 0;

@interface MallItemController ()<ItemToolBarDelegate, PointToolbarDelegate, ItemCoverImageCellDelegate, ItemInfoCellDelegate>

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *cartButton;

@property (nonatomic, strong) ItemToolBarView *itemToolBarView;
@property (nonatomic, strong) PointToolBarView *pointToolBarView;

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
    
    self.view.backgroundColor = ZLGray(245);
    
    self.title = @"商品详情";
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 40, 20);
    [shareButton setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightButton = shareButton;
    self.shareButton = shareButton;
    
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0, 0, 40, 20);
    [cartButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [cartButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [cartButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightDesButton = cartButton;
    self.cartButton = cartButton;
    
    self.contentTableView.height = SCREENHEIGHT - NAVBARHEIGHT - toolBarHeight;
    
    [self initData];
}

- (void)initData {
    [self loadData];
}

#pragma mark - properties
- (ItemToolBarView *)itemToolBarView {
    if (!_itemToolBarView) {
        _itemToolBarView = [[ItemToolBarView alloc] init];
        _itemToolBarView.frame = CGRectMake(0, SCREENHEIGHT - toolBarHeight, SCREENWIDTH, toolBarHeight);
        _itemToolBarView.delegate = self;
        _itemToolBarView.model = [ItemToolBarModel modelWithIsFav:NO status:StatusOnSell];
    }
    return _itemToolBarView;
}

- (PointToolBarView *)pointToolBarView {
    if (!_pointToolBarView) {
        _pointToolBarView = [[PointToolBarView alloc] init];
        _pointToolBarView.frame = CGRectMake(0, SCREENHEIGHT - toolBarHeight, SCREENWIDTH, toolBarHeight);
        _pointToolBarView.delegate = self;
    }
    return _pointToolBarView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case ItemDetailSectionItem:
            return 6;
            break;
        case ItemDetailSectionSKU:
            return 2;
            break;
        case ItemDetailSectionComment:
            return 2 + self.commentsInfoModel.comments.count + 1;
            break;
        case ItemDetailSectionShop:
            return self.shopInfoModel ? 2 : 0;
            break;
        case ItemDetailSectionImages: {
            if (self.itemInfoModel) {
                return self.itemInfoModel.detailContent.count + 1;
            } else {
                return 1;
            }
        }
            break;
        case ItemDetailSectionRecommend:
            return 1 + ceil(self.recommendsInfoModel.list.count /2.);
            break;
        case ItemDetailSectionEmpty:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section) {
        case ItemDetailSectionItem: {
            switch (row) {
                case ItemDetailRowImage: {
                    ItemCoverImageCell *cell = [ItemCoverImageCell dequeueReusableCellForTableView:tableView];
                    // debug
//                    self.itemInfoModel.coverImage.src = @[self.itemInfoModel.coverImage.src[0], self.itemInfoModel.coverImage.src[0], self.itemInfoModel.coverImage.src[0]];
                    cell.cellData = self.itemInfoModel.coverImage;
                    cell.delegate = self;
                    return cell;
                }
                    break;
                case ItemDetailRowInfo: {
                    ItemInfoCell *cell = [ItemInfoCell dequeueReusableCellForTableView:tableView];
                    cell.cellData = self.itemInfoModel;
                    cell.delegate = self;
                    cell.showShare = NO;
                    return cell;
                }
                    break;
                case ItemDetailRowRule: {
                    ItemRebateCell *cell = [ItemRebateCell dequeueReusableCellForTableView:tableView];
                    cell.cellData = self.cashback;
                    return cell;
                }
                    break;
                case ItemDetailRowTip: {
                    ItemTipsCell *cell = [ItemTipsCell dequeueReusableCellForTableView:tableView];
                    cell.cellData = self.quotaDesc;
                    return cell;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case ItemDetailSectionSKU: {
            if (itemDetailSKURowInfo == row) {
                ItemSKUSelectCell *cell = [ItemSKUSelectCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.selectedSkus;
                [cell reloadData];
                return cell;
            }
        }
            break;
        case ItemDetailSectionComment: {
            if (itemDetailCommentRowHead == row) {
                
            }
            else if (row <= self.commentsInfoModel.comments.count){
                
            }
            else if(row <= self.commentsInfoModel.comments.count + 1){
                
            }
        }
            break;
        case ItemDetailSectionShop: {
            if (itemDetailShopRowInfo == row ) {
                
            }
        }
            break;
        case ItemDetailSectionImages:
            if (itemDetailContentRowHead == row ) {
                ItemContentHeadCell *cell = [ItemContentHeadCell dequeueReusableCellForTableView:self.contentTableView];
                return cell;
            } else {
                ItemDetailContentModel *itemContent = self.itemInfoModel.detailContent[row - 1];
                if (itemContent) {
                    if ([@"image" isEqualToString:itemContent.type]) {
                        ItemContentImageCell *cell = [ItemContentImageCell dequeueReusableCellForTableView:tableView];
                        cell.cellData = itemContent;
                        return cell;
                    } else if ( [@"text" isEqualToString:itemContent.type] ) {
                        ItemContentImageCell *cell = [ItemContentImageCell dequeueReusableCellForTableView:tableView];
                        cell.cellData = itemContent.text;
                        return cell;
                    }
                    
                }
            }
            break;
        case ItemDetailSectionRecommend: {
            if (row == 0) {
            }else{
            }
        }
            break;
        case ItemDetailSectionEmpty:
            break;
        default:
            break;
    }
    
    BaseTableCell *cell = [BaseTableCell dequeueReusableCellForTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case ItemDetailSectionItem: {
            switch (row) {
                case ItemDetailRowImage:
                    height = [[ItemCoverImageCell heightForCell:self.itemInfoModel.coverImage] floatValue];
                    break;
                case ItemDetailRowInfo:
                    height = [[ItemInfoCell heightForCell:self.itemInfoModel] floatValue];
                    break;
                case ItemDetailRowRule:
                    height = [[ItemRebateCell heightForCell:self.cashback] floatValue];
                    break;
                case ItemDetailRowTip:
                    height = [[ItemTipsCell heightForCell:self.quotaDesc] floatValue];
                    break;
                default:
                    break;
            }
        }
            break;
        case ItemDetailSectionSKU: {
            
            if (![self.itemInfoModel.status isEqualToString:StatusOnSell]) {
                height = 0;
            } else {
                if (itemDetailSKURowInfo == row) {
                    height = [[ItemSKUSelectCell heightForCell:@""] floatValue];
                } else {
                    height = 14;
                }
            }
        }
            break;
        case ItemDetailSectionComment: {
            if (itemDetailCommentRowHead == row) {
            }
            else if (row <= self.commentsInfoModel.comments.count){
                
            }
            else if(row <= self.commentsInfoModel.comments.count + 1){
                
            }
        }
            break;
        case ItemDetailSectionShop: {
            if (itemDetailShopRowInfo == row ) {

            }
        }
            break;
        case ItemDetailSectionImages:
            if (itemDetailContentRowHead == row ) {
                height = [[ItemContentHeadCell heightForCell:nil] floatValue];
            } else {
                ItemDetailContentModel *itemContent = self.itemInfoModel.detailContent[row - 1];
                if (itemContent) {
                    if ( [@"image" isEqualToString:itemContent.type] ) {
                        height = [[ItemContentImageCell heightForCell:itemContent] floatValue];
                    } else if ( [@"text" isEqualToString:itemContent.type] ) {
                        height = [[ItemContentTextCell heightForCell:itemContent] floatValue];
                    }
                    
                }
            }
            break;
        case ItemDetailSectionRecommend: {
            if (row == 0) {
            }else{
            }
        }
            break;
        case ItemDetailSectionEmpty:
            break;
        default:
            break;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSInteger section = indexPath.section;
//    NSInteger row = indexPath.row;
//
//    if (ITEM_DETAIL_SECTION_SKU == section) {
//        if (ITEM_DETAIL_SKU_ROW_INFO == row) {
//            [self addToCartButtonDidClick];
//        }
//    }else if (ITEM_DETAIL_SECTION_COMMENT == section) {
//        if (ITEM_DETAIL_COMMENT_ROW_HEAD == row||(row == self.commentInfo.comments.count+1)) {
//            [[TTNavigationService sharedService] openUrl:self.commentInfo.link];
//        }
//    }
}

#pragma mark - image pannel
- (void)didTapCoverImageAtIndex:(NSInteger)index {
    
}

#pragma mark - ItemInfoCellDelegate
- (void)cell:(ItemInfoCell *)cell shareButtonTapped:(id)model {
    [self handleShareButton];
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
        [self didRefresh];
        
        if ([self.itemInfoModel.type isEqualToString:@"1"]) {
            [self.view addSubview:self.pointToolBarView];
        }else {
            [self.view addSubview:self.itemToolBarView];
            self.itemToolBarView.model = [ItemToolBarModel modelWithIsFav:self.itemInfoModel.isFav status:self.itemInfoModel.status];
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
