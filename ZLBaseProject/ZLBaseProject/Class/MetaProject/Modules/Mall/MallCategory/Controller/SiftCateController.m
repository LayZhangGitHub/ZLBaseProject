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

@interface SiftCateController ()

@property (nonatomic, strong) NSMutableArray *categorysItems;

@end

@implementation SiftCateController

- (void)viewDidLoad {
    self.scrollViewRefreshType = ScrollViewRefreshTypeFooter;
    [super viewDidLoad];
    
    [self showNavigationBar];
    
    self.view.backgroundColor = ZLGray(245);
    
    self.contentCollectionView.alwaysBounceVertical = YES;
    
    //    self.hasHeader = YES;
    //    self.isReady = NO;
    //    self.selectIndex = @"1";
    //    self.temp = 0;
    [self initData];
    
    self.title = @"123";
}

- (void)initData {
    //    self.items = [NSMutableArray array];
    self.categorysItems = [NSMutableArray array];
    [self loadData];
}


-(void)registCell {
    [self.contentCollectionView registerClass:[TMCateModuleCell class]
                   forCellWithReuseIdentifier:[TMCateModuleCell cellIdentifier]];
    
//    [self.contentCollectionView registerClass:[MCCategorySelectCell class] forCellWithReuseIdentifier:[MCCategorySelectCell cellIdentifier]];
    
    [self.contentCollectionView registerClass:[BaseCollectionCell class]
                   forCellWithReuseIdentifier:[BaseCollectionCell cellIdentifier]];
    
//    [self.contentCollectionView registerClass:[WallItemCell class] forCellWithReuseIdentifier:[WallItemCell cellIdentifier]];
}

#pragma mark - collection delegate
- (NSInteger)headerSectionCount {
    return 2;
}

- (NSInteger)itemCount {
//    return self.items.count;
    return 0;
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
//        MCCategorySelectCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[MCCategorySelectCell cellIdentifier] forIndexPath:indexPath];
//        cell.index = self.selectIndex;
//        cell.delegate = self;
//        cell.temp = self.temp;
//        cell.cellData = self.siftsArray;
//        [cell reloadData];
//        return cell;
    }
    
    BaseCollectionCell * cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                                forIndexPath:indexPath];
    return cell;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 2) {
//        WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
//
//        WallItemCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[WallItemCell cellIdentifier] forIndexPath:indexPath];
//
//        cell.cellData = wallItem;
//
//        [cell reloadData];
//
//        return cell;
    }
    
    BaseCollectionCell *cell = [BaseCollectionCell dequeueCellForCollection:self.contentCollectionView
                                                               forIndexPath:indexPath];
    return cell;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    InstItemModel *instItem = self.items
//    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
//
//    return CGSizeMake(CELL_WIDTH, [WallItemCell heightForCell:wallItem]);
    return CGSizeZero;
}


- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 14;
    
    if(indexPath.section == 0 ){
        if (indexPath.item == 1) {
            height = [[TMCateModuleCell heightForCell:self.categorysItems] floatValue];
        }else if (indexPath.item == 0||indexPath.item == 2) {
            if (self.categorysItems.count == 0) {
                height = 0;
            }
        }
    }else if (indexPath.section == 1) {
//        height = [MCCategorySelectCell heightForCell:@""];
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
        else {
            return 2;
        }
        return 0;
    }
    
    return [self itemCount];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
//
//    [[TTNavigationService sharedService] openUrl:wallItem.link];
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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    params[@"cateId"] = self.cateId;
    //
    //    [params setSafeObject:self.KeyValue forKey:self.keyName];
    
    [SiftCateRequest getMCCategoryDataWithParams:params success:^(TMCateSiftResultModel *resultModel) {
        //        [self hideEmptyTips];
        //        [self.items removeAllObjects];
        [self.categorysItems removeAllObjects];
        
        if ( resultModel && resultModel.items ) {
            
            //            [self.items addObjectsFromSafeArray:resultModel.items.list];
            
            [self.categorysItems addObjectsFromArray:resultModel.categories];
            
            self.wp = resultModel.items.wp;
            self.title = resultModel.title?resultModel.title:@"类目";
            
            //            self.siftsArray = resultModel.sifts;
            //
            //            [self render];
            //
            //
            //            if ( resultModel.items.isEnd ) {
            //                self.collectionView.showsInfiniteScrolling = NO;
            //            } else {
            //                self.collectionView.showsInfiniteScrolling = YES;
            //            }
            
        } else {
            
            //            self.collectionView.showsInfiniteScrolling = NO;
        }
        if (resultModel.items.list.count == 0) {
            [self showTips:@"没有相关商品哦" onView:self.contentCollectionView];
        }
        
        //        self.isReady = YES;
        [self didRefresh];
        
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        
        [self didRefresh];
        [self showNotice:status.msg];
        [self reloadData];
    }];
}





@end
