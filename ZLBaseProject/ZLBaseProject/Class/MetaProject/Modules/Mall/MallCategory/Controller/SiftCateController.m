//
//  TMCategoryController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "SiftCateController.h"

#import "SiftCateRequest.h"

#import "TMCateModuleCell.h"
#import "BaseCollectionCell.h"
#import "TMOptionSelectCell.h"
#import "TMInstItemCell.h"

@interface SiftCateController ()<OptionSelectView>

@property (nonatomic, strong) NSMutableArray *categorysItems;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *siftsArray;

@property (nonatomic, strong) OptionSelectView *optionSelectView;

// sift 筛选 值
@property (nonatomic, strong) NSString *siftName;
@property (nonatomic, strong) NSString *siftValue;
@property (nonatomic, strong) NSString *siftIndex;

@end

@implementation SiftCateController

- (void)viewDidLoad {
    self.scrollViewRefreshType = ScrollViewRefreshTypeFooter | ScrollViewRefreshTypeHeader;
    [super viewDidLoad];
    
    [self showNavigationBar];
    
    self.view.backgroundColor = ZLGray(245);
    
    self.contentCollectionView.alwaysBounceVertical = YES;
    
    self.siftIndex = @"0";
    [self initData];
    
    self.title = @"loading...";
}

- (void)initData {
    self.items = [NSMutableArray array];
    self.categorysItems = [NSMutableArray array];
    [self loadData];
}

-(void)registCell {
    [self.contentCollectionView registerClass:[TMCateModuleCell class]
                   forCellWithReuseIdentifier:[TMCateModuleCell cellIdentifier]];
    
    [self.contentCollectionView registerClass:[TMOptionSelectCell class]
                   forCellWithReuseIdentifier:[TMOptionSelectCell cellIdentifier]];
    
    [self.contentCollectionView registerClass:[BaseCollectionCell class]
                   forCellWithReuseIdentifier:[BaseCollectionCell cellIdentifier]];
    
    [self.contentCollectionView registerClass:[TMInstItemCell class]
                   forCellWithReuseIdentifier:[TMInstItemCell cellIdentifier]];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = 0;
    UICollectionViewLayoutAttributes *siftAtt = [self.contentCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
    height = siftAtt.frame.origin.y;
    TMOptionSelectCell *cell = (TMOptionSelectCell *)[self.contentCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
    
    if (scrollView.contentOffset.y > height) {
        if (!self.optionSelectView) {
            self.optionSelectView = (OptionSelectView *)[cell.optionSelectView copy];
            [self.view addSubview:self.optionSelectView];
            self.optionSelectView.size = cell.optionSelectView.size;
            self.optionSelectView.top = NAVBARHEIGHT;
        }
    }else{
        if (self.optionSelectView) {
            [self.optionSelectView removeFromSuperview];
            self.optionSelectView = nil;
        }
    }
}

#pragma mark - collection delegate
- (NSInteger)headerSectionCount {
    return 2;
}

- (NSInteger)itemSectionCount {
    return 1;
}

- (NSInteger)itemCount {
    return self.items.count;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.item == 1) {
            TMCateModuleCell *cell = [TMCateModuleCell dequeueCellForCollection:self.contentCollectionView
                                                                   forIndexPath:indexPath];
            cell.cellData = self.categorysItems;
            return cell;
        }
    }else if (indexPath.section == 1) {
        //        if (indexPath.item == 0) {
        TMOptionSelectCell *cell = [TMOptionSelectCell dequeueCellForCollection:self.contentCollectionView
                                                                   forIndexPath:indexPath];
        cell.optionSelectView.initIndex = [self.siftIndex integerValue];
        cell.optionSelectView.delegate = self;
        cell.cellData = self.siftsArray;
        return cell;
        //        }
    }
    
    BaseCollectionCell * cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                                forIndexPath:indexPath];
    return cell;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        InstItemModel *item = self.items[indexPath.item];
        
        TMInstItemCell *cell = [TMInstItemCell dequeueCellForCollection:self.contentCollectionView
                                                           forIndexPath:indexPath];
        cell.cellData = item;
        return cell;
    }
    
    BaseCollectionCell *cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                               forIndexPath:indexPath];
    return cell;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    InstItemModel *item = self.items[indexPath.item];
    return CGSizeMake([[TMInstItemCell widthForCell:item] floatValue], [[TMInstItemCell heightForCell:item] floatValue]);
}

- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 14;
    
    if(indexPath.section == 0){
        if (indexPath.item == 1) {
            height = [[TMCateModuleCell heightForCell:self.categorysItems] floatValue];
        }else if (indexPath.item == 0||indexPath.item == 2) {
            if (self.categorysItems.count == 0) {
                height = 0;
            }
        }
    }else if (indexPath.section == 1) {
        //        if (indexPath.item == 0) {
        height = [[TMOptionSelectCell heightForCell:@""] floatValue];
        //        }
    }
    return CGSizeMake(SCREENWIDTH, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self headerSectionCount] > section) {
        if (section == 0) {
            return 3; //2
        }else if (section == 1) {
            return 1; //1
        }
    }
    return [self itemCount];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    InstItemModel *item = self.items[indexPath.item];
    [[ZLNavigationService sharedService] openUrl:item.link];
}

#pragma mark - optionselectview
- (void)optionChooseIndex:(NSInteger)index keyName:(NSString *)name keyValue:(NSString *)keyValue {
    ZLLog(@"select index is ............. %d", index);
    self.siftIndex = [NSString stringWithFormat:@"%ld", index];
    self.siftName = name;
    self.siftValue = keyValue;
    
    [self initData];
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
    [self doLoadMore];
}

- (void)loadData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    
    params[@"cateId"] = self.cateId;
    params[self.siftName] = self.siftValue;
    
    [SiftCateRequest getMCCategoryDataWithParams:params success:^(TMCateSiftResultModel *resultModel) {
        [self hideTips];
        [self hideFailedView];
        [self.items removeAllObjects];
        [self.categorysItems removeAllObjects];
        
        if (resultModel && resultModel.items) {
            
            [self.items addObjectsFromArray:resultModel.items.list];
            
            [self.categorysItems addObjectsFromArray:resultModel.categories];
            
            self.wp = resultModel.items.wp;
            self.title = resultModel.title?resultModel.title:@"类目";
            
            self.siftsArray = resultModel.sifts;
            
            [self couldScrollToFooter:!resultModel.items.isEnd];
            
        } else {
            [self couldScrollToFooter:NO];
        }
        
        if (resultModel.items.list.count == 0) {
            [self showTips:@"没有相关商品哦" onView:self.contentCollectionView];
        }
        
        [self didRefresh];
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        [self hideTips];
        [self showFaildView];
        [self didRefresh];
        [self showNotice:status.msg];
        [self reloadData];
    }];
}

- (void)doLoadMore {
    [super doLoadMore];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    
    params[@"wp"] = self.wp;
    
    [SiftCateRequest getMCCategoryDataWithParams:params success:^(TMCateSiftResultModel *resultModel) {
        
        if (resultModel && resultModel.items) {
            [self.items addObjectsFromArray:resultModel.items.list];
            
            self.wp = resultModel.items.wp;
            [self couldScrollToFooter:!resultModel.items.isEnd];
        }
        
        [self didLoadMore];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self didLoadMore];
        [self reloadData];
    }];
}

@end
