//
//  BaseController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseController.h"
#import "ZLTipsView.h"


@interface BaseController ()

@property (nonatomic, strong) ZLTipsView *tipsView;
@property (nonatomic, strong) ZLFailedAndReloadView *failedView;

@end

@implementation BaseController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ZLFuncLineLog();
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    ZLFuncLineLog();
    //    DBG(@"viewWillDisappear %@", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZLThemeCtrInstance.backgroundColor;
    [self.navigationController.navigationBar setHidden:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needBlurEffect = YES;
}

#pragma mark - override uiviewcontroller settitle
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    if (_navigationBar) {
        [_navigationBar setTitle:title];
    }
}

- (void)showNavigationBar {
    
    if (self.isHideNavigationBar) {
        ZLWarningLog(@"navigation is hide, can not show!");
        return;
    }
    
    if (!_navigationBar) {
        _navigationBar = [[ZLNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBARHEIGHT) needBlurEffect:self.needBlurEffect];
        _navigationBar.backgroundColor = ZLThemeCtrInstance.navigationBackgroundColor;
        _navigationBar.tintColor = ZLThemeCtrInstance.navigationButtonColor;
        _navigationBar.title = self.title;
        
        [self.view addSubview:_navigationBar];
    }
    
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        UIButton *backButton = [UIButton buttonWithTarget:self
                                                   action:@selector(navigationBackAction)
                                         forControlEvents:UIControlEventTouchUpInside];
        backButton.size = CGSizeMake(40, 40);
        [_navigationBar setLeftButton:backButton];
    }
    [_navigationBar setBottomBorderColor:ZLThemeCtrInstance.navigationBottomBorderColor];
    
    _navigationBar.hidden = NO;
}

- (void)hideNavigationBar {
    if (_navigationBar) {
        _navigationBar.hidden = YES;
    }
}

- (void)navigationBackAction {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - alert
- (void)showAlert:(NSString *)message {
    [self showAlert:message didClickButton:nil willDissmiss:nil didDissmiss:nil];
}

- (void)showAlert:(NSString *)message didClickButton:(ClickbuttonAtIndex)didClickBlock {
    [self showAlert:message
     didClickButton:didClickBlock
       willDissmiss:nil didDissmiss:nil];
}

- (void)showAlert:(NSString *)message
   didClickButton:(ClickbuttonAtIndex)didClickBlock
     willDissmiss:(WillDismissionAtIndex)willDismissBlock
      didDissmiss:(DidDismissionAtIndex)didDismissBlock {
    ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       message2:nil
                                                  containerView:nil
                                             confirmButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    if (didClickBlock) {
        alertView.clickButtonBlock = didClickBlock;
    }
    if (willDismissBlock) {
        alertView.willDismissBlock = willDismissBlock;
    }
    if (didDismissBlock) {
        alertView.didDismissBlock = didDismissBlock;
    }
    [alertView show];
}

#pragma mark - tips
- (void)showTips:(NSString *)tips {
    [self showTips:tips onView:self.view];
}

- (void)showTips:(NSString *)tips onView:(UIView *)onView {
    [self showTips:tips onView:onView offsetTop:0];
}

- (void)showTips:(NSString *)tips onView:(UIView *)onView offsetTop:(CGFloat)top {
    if (!_tipsView) {
        _tipsView = [[ZLTipsView alloc] initWithFrame:onView.frame tips:tips];
        _tipsView.top = top;
        [onView addSubview:_tipsView];
    }
}

- (void)hideTips {
    _tipsView.hidden = YES;
    [_tipsView removeFromSuperview];
    _tipsView = nil;
}

#pragma mark - failed and reload
- (void)showFailedOnView:(UIView *)onView {
    if (!_failedView) {
        _failedView = [[ZLFailedAndReloadView alloc] initWithFrame:onView.bounds];
        _failedView.delegate = self;
        [onView addSubview:_failedView];
    } else {
        [_failedView didFinishLoading];
    }
}

- (void)showFaildView {
    if (!_failedView) {
        if (_navigationBar) {
            _failedView = [[ZLFailedAndReloadView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, self.view.width, self.view.height - NAVBARHEIGHT)];
            [self.view insertSubview:_failedView belowSubview:_navigationBar];
        } else {
            _failedView = [[ZLFailedAndReloadView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:_failedView];
        }
        _failedView.delegate = self;
    } else {
        [_failedView didFinishLoading];
    }
}

- (void)hideFailedView {
    [_failedView removeFromSuperview];
    _failedView = nil;
}

#pragma mark - show toast
- (void)showNotice:(NSString *)notice {
    [ShowToast showNotice:notice];
}

- (void)showNotice:(NSString *)notice duration:(NSTimeInterval)duration {
    [ShowToast showNotice:notice duraton:duration];
}

@end
