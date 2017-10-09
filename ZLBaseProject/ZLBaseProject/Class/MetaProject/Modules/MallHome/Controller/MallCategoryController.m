//
//  MallCategoryController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/29.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MallCategoryController.h"

#import "MallHomeRequest.h"

#import "BaseCollectionCell.h"

#import "MHModule20Cell.h"
#import "MHModule21Cell.h"
#import "MHModule22Cell.h"
#import "MHModule23Cell.h"
#import "MHModule24Cell.h"
#import "MHModule25Cell.h"

@interface MallCategoryController ()

@property (nonatomic, strong) NSArray *items;

//@property (nonatomic, strong) UIButton *cartButton;
@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation MallCategoryController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[ZLTabbarItem alloc] initWithTitle:@"分类"
                                                   titleColor:ZLGray(153)
                                           selectedTitleColor:ZLRedColor
                                                         icon:[UIImage imageNamed:@"icon_tabbar_category_normal"]
                                                 selectedIcon:[UIImage imageNamed:@"icon_tabbar_category_select"]];
    }
    return self;
}

- (void)viewDidLoad {
    self.scrollViewRefreshType = ScrollViewRefreshTypeHeader;
    [super viewDidLoad];
    self.view.backgroundColor = ZLGray(245);
    [self showNavigationBar];
    
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 40, 20);
    [infoButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    infoButton.right = SCREENWIDTH - 12;
    infoButton.centerY = (STATUSBARHEIGHT + self.navigationBar.height)/2;
    self.navigationBar.rightButton = infoButton;
//    self.cartButton = infoButton;
    
    [self.navigationBar addSubview:self.searchTextField];
    
    self.contentCollectionView.height = SCREENHEIGHT - NAVBARHEIGHT - TABBARHEIGHT;
    self.contentCollectionView.alwaysBounceVertical = YES;
    
    [self initData];
}

#pragma mark - properties
- (UITextField*)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(12, STATUSBARHEIGHT + 7, SCREENWIDTH - 12 - 56, 30)];
        _searchTextField.font = ZLNormalFont(14);
        _searchTextField.placeholder = @"搜索商品";
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

#pragma mark - navigation handle
- (void) handleShowCartButton {
//    [[ZLNavigationService sharedService] openUrl:LOCALSCHEMA(@"mallCart")];
}

- (void)handleSearchButton {
//    [[ZLNavigationService sharedService] openUrl:LOCALSCHEMA(@"search")];
}

#pragma mark - loadData
- (void)initData {
    self.items = [NSArray array];
    [self loadData];
}

- (void)registCell {
    for (int i = 20; i <= 25; i++) {
        NSString *classStr = [NSString stringWithFormat:@"MHModule%02dCell", i];
        Class class = NSClassFromString(classStr);
        [self.contentCollectionView registerClass:[class class]
                       forCellWithReuseIdentifier:[class performSelector:@selector(cellIdentifier)]];
    }
    
    [self.contentCollectionView registerClass:[BaseCollectionCell class]
                   forCellWithReuseIdentifier:[BaseCollectionCell cellIdentifier]];
}

- (NSInteger)headerSectionCount {
    return self.items.count;
}


#pragma mark - dequeue cell
- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    MHModuleModel *model = self.items[indexPath.section];
    if (model.type != 20) {
        if (indexPath.item == 0) {
            NSString *classStr = [NSString stringWithFormat:@"MHModule%02dCell",model.type];
            Class class = NSClassFromString(classStr);
            BaseCollectionCell *cell =
            [class performSelector:@selector(dequeueCellForCollection:forIndexPath:)
                        withObject:self.contentCollectionView
                        withObject:indexPath];
            cell.cellData = model;
            return cell;
        }
    }else if(model.type == 20) {
        
        MHModule20Cell *cell = [MHModule20Cell dequeueCellForCollection:self.contentCollectionView
                                                                       forIndexPath:indexPath];
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        [tempDic setObject:model.items[indexPath.row * 2] forKey:@"leftItem"];
        [tempDic setObject:model.items[indexPath.row * 2 + 1] forKey:@"rightItem"];
        cell.cellData = tempDic;
        return cell;
    }
    
    BaseCollectionCell * cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                                            forIndexPath:indexPath];
    return cell;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCollectionCell *cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                                               forIndexPath:indexPath];
    return cell;
}

#pragma mark - item size
// header item size
- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 14;
    MHModuleModel *model = self.items[indexPath.section];
    if(model.type !=20 && indexPath.item == 0){
        NSString *classStr = [NSString stringWithFormat:@"MHModule%02dCell",model.type];
        Class class = NSClassFromString(classStr);
        height = [[class performSelector:@selector(heightForCell:) withObject:model] floatValue];
//        if (model.type == 21) {
//            NSMutableArray *a = [NSMutableArray arrayWithArray:model.items];
//            [a addObjectsFromArray:model.items];
//            model.items = a;
//        }
    }else{
        if (model.type == 25) {
            height = 0;
        }else if (model.type == 20) {
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
            [tempDic setObject:model.items[indexPath.row * 2] forKey:@"leftItem"];
            [tempDic setObject:model.items[indexPath.row * 2 + 1] forKey:@"rightItem"];
            height = [[MHModule20Cell heightForCell:tempDic] floatValue];
        }
    }
    return CGSizeMake(SCREENWIDTH, height);
}

// normalitem
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    height = [[BaseCollectionCell heightForCell:nil] floatValue];
    
    return CGSizeMake(SCREENWIDTH, height);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    MHModuleModel *model = self.items[section];
    if ([self headerSectionCount] > section) {
        if (section == 0 ) {
            return 1;
        }else {
            if (model.type==20) {
                return ceil(model.items.count / 2.0f);
            }
            return 2;
        }
    }
    return 0;
}

#pragma mark - failed and reload deleaget
- (void)failedViewBeginReload:(ZLFailedAndReloadView *)reloadView {
    NSLog(@"reoload data here!!!");
    [self loadData];
}

#pragma mark - header and footer refresh
- (void)willRefresh {
    [super willRefresh];
    [self initData];
}

- (void)willLoadMore {
    [super willLoadMore];
    [self didLoadMore];
}

- (void)loadData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [MallHomeRequest getCategoryDataWithParams:params success:^(MHResultModel *resultModel) {
        [self hideFailedView];
        if (resultModel) {
            self.items = [NSArray arrayWithArray:resultModel.list];
        }
        for (MHModuleModel *model in self.items) {
            NSLog(@"%d", model.type);
        }
        [self didRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self hideFailedView];
        [self didRefresh];
        [self showNotice:status.msg];
        [self showFaildView];
        [self reloadData];
    }];
}



@end
