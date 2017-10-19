//
//  ShopInfoController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopInfoController.h"

@interface ShopInfoController ()

@property (nonatomic, strong) UITextField *searchTextField;

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

@end
