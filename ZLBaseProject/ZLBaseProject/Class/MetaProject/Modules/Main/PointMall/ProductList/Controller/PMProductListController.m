//
//  PMProductListController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PMProductListController.h"
#import "PointMallRequest.h"
#import "PMCatrogryCell.h"
#import "PMTitleHeaderCell.h"
#import "PMInstrumentCell.h"

@interface PMProductListController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation PMProductListController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[ZLTabbarItem alloc] initWithTitle:@"淘米商城"
                                                   titleColor:ZLGray(153)
                                           selectedTitleColor:ZLRedColor
                                                         icon:[UIImage imageNamed:@"icon_tabbar_point_normal"]
                                                 selectedIcon:[UIImage imageNamed:@"icon_tabbar_point_select"]];
    }
    return self;
}


- (void)viewDidLoad {
    self.scrollViewRefreshType = ScrollViewRefreshTypeHeader;
    [super viewDidLoad];
    
    self.view.backgroundColor = ZLGray(245);
    self.contentCollectionView.alwaysBounceVertical = YES;
    self.contentCollectionView.height = SCREENHEIGHT - NAVBARHEIGHT - TABBARHEIGHT;
    
    [self showNavigationBar];
    [self.navigationBar addSubview:self.searchTextField];
    
    [self initData];
}

- (void)initData {
    self.items = [NSMutableArray array];
    [self loadData];
}

- (void)handleSearchButton {
    //    [[ZLNavigationService sharedService] openUrl:LOCALSCHEMA(@"search?cateId=%@&type=pointSearch",self.cateId)];
}

- (void)registCell {
    [self.contentCollectionView registerClass:[PMInstrumentCell class] forCellWithReuseIdentifier:[PMInstrumentCell cellIdentifier]];
    [self.contentCollectionView registerClass:[PMCatrogryCell class] forCellWithReuseIdentifier:[PMCatrogryCell cellIdentifier]];
    [self.contentCollectionView registerClass:[PMTitleHeaderCell class] forCellWithReuseIdentifier:[PMTitleHeaderCell cellIdentifier]];
    
    [self.contentCollectionView registerClass:[BaseCollectionCell class] forCellWithReuseIdentifier:[BaseCollectionCell cellIdentifier]];
}

- (NSInteger)itemSectionCount {
    return 1;
}

- (NSInteger)headerSectionCount {
    return self.items.count + 1;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        PMCatrogryCell *cell = [PMCatrogryCell dequeueCellForCollection:self.contentCollectionView
                                                           forIndexPath:indexPath];
        cell.cellData = self.categoryArray;
        return cell;
    }
    
    if (indexPath.section > 0) {
        PMListItemMOdel *list = self.items[indexPath.section - 1];
        if (indexPath.item == 0) {
            PMTitleHeaderCell *cell = [PMTitleHeaderCell dequeueCellForCollection:self.contentCollectionView
                                                                     forIndexPath:indexPath];
            cell.cellData = list.title;
            return cell;
        }else {
            PMInstrumentCell *cell = [PMInstrumentCell dequeueCellForCollection:self.contentCollectionView
                                                                   forIndexPath:indexPath];

            NSMutableDictionary *items = [NSMutableDictionary dictionary];
            items[@"leftItem"]  = list.items[(indexPath.row-1) * 2];
            items[@"rightItem"] = list.items[(indexPath.row-1) * 2 + 1];
            cell.cellData = items;
            return cell;
        }

    }
    
    BaseCollectionCell * cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                                forIndexPath:indexPath];
    return cell;
}

- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = [[PMCatrogryCell heightForCell:self.categoryArray] floatValue];
    }
    
    if (indexPath.section > 0) {
        if (indexPath.item == 0) {
            PMListItemMOdel *list = self.items[indexPath.section - 1];
            height = [[PMTitleHeaderCell heightForCell:list.title] floatValue];
        }else {
            PMListItemMOdel *list = self.items[indexPath.section - 1];

            NSMutableDictionary *items = [NSMutableDictionary dictionary];
            items[@"leftItem"]  = list.items[(indexPath.row - 1) * 2];
            items[@"rightItem"] = list.items[(indexPath.row - 1) * 2 + 1];
            height = [[PMInstrumentCell heightForCell:items] floatValue];
        }
    }
    return CGSizeMake(SCREENWIDTH, height);
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCollectionCell * cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                                forIndexPath:indexPath];
    return cell;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREENWIDTH - 15) / 2, 0);
}


#pragma mark - WallViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self headerSectionCount] > section) {
        
        if (section == 0 ) {
            return 1;
        } else {
            PMListItemMOdel *list = self.items[section-1];
            return ceil(list.items.count/2.0f) + 1;
        }
        return 0;
    }
    
    return 0;
}

#pragma mark - properties
- (UITextField*)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, STATUSBARHEIGHT + 7, SCREENWIDTH - 40, 30)];
        _searchTextField.font = ZLNormalFont(14);
        _searchTextField.placeholder = @"搜索商品";
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.backgroundColor = ZLGray(240);
        _searchTextField.tintColor = ZLGray(140);
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.layer.cornerRadius = 2.;
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.delegate = self;
        _searchTextField.centerX = SCREENWIDTH / 2;
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

#pragma mark - failed and reload deleaget
- (void)failedViewBeginReload:(ZLFailedAndReloadView *)reloadView {
    [self loadData];
}

#pragma mark - header and footer refresh
- (void)willRefresh {
    [super willRefresh];
    [self doRefresh];
}

- (void)doRefresh {
    [super doRefresh];
    [self loadData];
}

- (void)willLoadMore {
    [super willLoadMore];
    [self doLoadMore];
}

- (void)doLoadMore {
    [super doLoadMore];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.wp forKey:@"wp"];
    [PointMallRequest getProductMoreDataWithParams:params success:^(ProductListResultModel *resultModel) {
        
        if ( resultModel && resultModel.list ) {
            [self.items addObjectsFromArray:resultModel.list];
            self.wp = resultModel.wp;
            
            [self couldScrollToFooter:!resultModel.isEnd];
        }
        [self reloadData];
        [self didLoadMore];
    } failure:^(StatusModel *status) {
        [self didLoadMore];
    }];
}

- (void)loadData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
//    [params setObject:self.cateId forKey:@"cateId"];
    params[@"cateId"] = self.cateId;
    
    [PointMallRequest getProductListDataWithParams:params success:^(ProductListResultModel *resultModel) {
        [self hideFailedView];
        
        [self.items removeAllObjects];
        
        if (resultModel && resultModel.list) {
            
            [self.items addObjectsFromArray:resultModel.list];
            
            // 头部的 数据
            self.categoryArray = resultModel.cates;
            
            self.wp = resultModel.wp;
            [self couldScrollToFooter:!resultModel.isEnd];
            
        } else {
            NSString *noticeStr = @"没有找到相关商品哦";
            [self showTips:noticeStr onView:self.contentCollectionView];
            [self couldScrollToFooter:NO];
        }
        
        [self didRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self hideFailedView];
        [self didRefresh];
        [self showFaildView];
        [self showNotice:status.msg];
    }];
}

@end
