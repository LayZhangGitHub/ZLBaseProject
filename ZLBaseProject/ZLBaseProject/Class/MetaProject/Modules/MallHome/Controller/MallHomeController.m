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
#import "BaseCollectionCell.h"

#import "MHModuleModel.h"

#import "MHModule01Cell.h"
#import "MHModule05Cell.h"

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
//    [self showTips:@"te/st"];
//    [self showFaildView];
}

- (void)registCell {
    [self.contentCollectionView registerClass:[MHModule01Cell class]
                   forCellWithReuseIdentifier:[MHModule01Cell cellIdentifier]];
    [self.contentCollectionView registerClass:[MHModule05Cell class]
                   forCellWithReuseIdentifier:[MHModule05Cell cellIdentifier]];
    
    [self.contentCollectionView registerClass:[BaseCollectionCell class]
                   forCellWithReuseIdentifier:[BaseCollectionCell cellIdentifier]];
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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [MallHomeRequest getHomeDataWithParams:params success:^(MHResultModel *resultModel) {
//        [self hideErrorTips];
        
        [self.items removeAllObjects];
        self.resultModel = resultModel;
        
        for (MHModuleModel *model in resultModel.list) {
            NSLog(@"type is %d", model.type);
        }
        
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
        [self reloadData];
//        [self showErrorTips];
//        self.lastRefresh = NO;
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_APP_LAUNCH_REMOVE object:nil];
    }];
}


- (NSInteger)itemCount
{
    return 0;
}

- (NSInteger)headerCount
{
    
    return self.items.count;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    MHModuleModel *model = [self.items objectAtIndex:indexPath.section];
    
    if (model.type != 20) {
        if (indexPath.item == 0 && (model.type == 1 || model.type == 5)) {
            NSString *classStr = [NSString stringWithFormat:@"MHModule%02dCell",model.type];
            Class class = NSClassFromString(classStr);
            BaseCollectionCell *cell = [class performSelector:@selector(dequeueReusableCellForCollectionView:forIndexPath:) withObject:self.contentCollectionView withObject:indexPath];
            cell.cellData = model;
            [cell reloadData];
            return cell;
        }
        
//        if (indexPath.item == 0) {
//            NSString *classStr = [NSString stringWithFormat:@"MHModule%02dCell",model.type];
//            Class class = NSClassFromString(classStr);
//            BaseCollectionCell *cell = [self.contentCollectionView dequeueReusableCellWithReuseIdentifier:[class cellIdentifier] forIndexPath:indexPath];
//            cell.cellData = model;
//            [cell reloadData];
//            return cell;
//        }
    }
//    else if(model.type == 20) {
//        MHModule20Cell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[MHModule20Cell cellIdentifier] forIndexPath:indexPath];
//
//        NSMutableDictionary *items = [NSMutableDictionary dictionary];
//        [items setSafeObject:[model.items safeObjectAtIndex:indexPath.row*2] forKey:@"leftItem"];
//        [items setSafeObject:[model.items safeObjectAtIndex:indexPath.row*2 + 1] forKey:@"rightItem"];
//        cell.cellData = items;
//        [cell reloadData];
//        return cell;
//    }
    
    BaseCollectionCell * cell = [self.contentCollectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
}


- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSRunLoop *currentThreadRunLoop = [NSRunLoop currentRunLoop];
    //    NSRunLoopMode mode = currentThreadRunLoop.currentMode;
    //    NSLog(@"-----------current mode:%@-----------",mode);
    
    BaseCollectionCell *cell;
    
//    id wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    cell = [self.contentCollectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
    
}


- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 14;
    MHModuleModel *model = [self.items objectAtIndex:indexPath.section];
    if(model.type!=20 && indexPath.item == 0){
        
        if (model.type == 1) {
            height = [MHModule01Cell heightForCell:model];
//        }
//        else if (model.type == 2){
//            height = [MHModule02Cell heightForCell:model];
//        }else if (model.type == 3){
//            height = [MHModule03Cell heightForCell:model];
//        }else if (model.type == 4){
//            height = [MHModule04Cell heightForCell:model];
        }else if (model.type == 5){
            height = [MHModule05Cell heightForCell:model]; }
//        }else if (model.type == 6){
//            height = [MHModule06Cell heightForCell:model];
//        }else if (model.type == 7){
//            height = [MHModule07Cell heightForCell:model];
//        }else if (model.type == 8){
//            height = [MHModule08Cell heightForCell:model];
//        }else if (model.type == 9){
//            height = [MHModule09Cell heightForCell:model];
//        }else if (model.type == 10){
//            height = [MHModule10Cell heightForCell:model];
//        }else if (model.type == 11){
//            height = [MHModule11Cell heightForCell:model];
//        }else if (model.type == 12){
//            height = [MHModule12Cell heightForCell:model];
//        }else if (model.type == 13){
//            height = [MHModule13Cell heightForCell:model];
//        }else if (model.type == 14){
//            height = [MHModule14Cell heightForCell:model];
//        }else if (model.type == 15){
//            height = [MHModule15Cell heightForCell:model];
//        }else if (model.type == 16){
//            height = [MHModule16Cell heightForCell:model];
//        }else if (model.type == 17){
//            height = [MHModule17Cell heightForCell:model];
//        }else if (model.type == 18){
//            height = [MHModule18Cell heightForCell:model];
//        }else if (model.type == 19){
//            height = [MHModule19Cell heightForCell:model];
//        }
        
    }
//    else if (model.type == 20) {
//        NSMutableDictionary *items = [NSMutableDictionary dictionary];
//        [items setObject:[model.items objectAtIndex:indexPath.row*2] forKey:@"leftItem"];
//        [items setObject:[model.items objectAtIndex:indexPath.row*2 + 1] forKey:@"rightItem"];
////        height = [MHModule20Cell heightForCell:items];
//    }
    return CGSizeMake(SCREENWIDTH, height);
}


- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    id wallItem = [self.items objectAtIndex:indexPath.item ];
    
    height = [BaseCollectionCell heightForCell:wallItem];
    return CGSizeMake((SCREENWIDTH - 15) / 2, height);
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    MHModuleModel *model = [self.items objectAtIndex:section];
    if ( self.hasHeader && [self headerCount] > section ) {
        if (section == 0 ) {
            return 1;
        }
        else {
            if (model.type == 20) {
                return ceil(model.items.count/2.0f);
            }
            return 2;
        }
        return 0;
    }
    
    return [self itemCount];
}

#pragma mark - failed and reload deleaget
- (void)failedViewBeginReload:(ZLFailedAndReloadView *)reloadView {
    NSLog(@"reoload data here!!!");
    [self initData];
}


@end
