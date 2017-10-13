//
//  ZLPagerController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLPagerController.h"

@interface ZLPagerController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>

@property UIScrollView *tabsView;
@property UIView *singleTabsView;
@property UIView *contentView;

@property UIView *selectedBorder;
@property UIImageView *shadowLineLeft;
@property UIView *firstSelectedBorder;

@property (getter = isAnimatingToTab, assign) BOOL animatingToTab;

@property UIPageViewController *pageViewController;
@property (assign) id<UIScrollViewDelegate> actualDelegate;


@property NSMutableArray *tabs;
@property NSMutableArray *contents;

@property NSMutableArray *titles;

@property (nonatomic) NSUInteger tabCount;
@property (nonatomic) NSUInteger activeTabIndex;
@property (nonatomic) NSUInteger activeContentIndex;


@property (nonatomic) UIColor *tabsViewBackgroundColor;
@property (nonatomic) UIColor *contentViewBackgroundColor;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, assign) BOOL isChoosing;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation ZLPagerController

#pragma mark - Init
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSettings];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self defaultSettings];
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    [self layoutSubviews];
}

- (void)layoutSubviews {
    
    CGFloat topLayoutGuide = self.isHideNavigationBar ? STATUSBARHEIGHT : NAVBARHEIGHT;
    
    CGRect frame = self.tabsView.frame;
    frame.origin.x = 0.0;
    frame.origin.y = topLayoutGuide;
    frame.size.width = CGRectGetWidth(self.view.frame);
    frame.size.height = self.hideTab?0:TABSVIEWHEIGHT;
    self.tabsView.frame = frame;
    
    frame = self.contentView.frame;
    frame.origin.x = 0.0;
    frame.origin.y = topLayoutGuide + CGRectGetHeight(self.tabsView.frame);
    if (self.noScroll) {
        self.singleTabsView.height = self.hideTab?0:TABSVIEWHEIGHT;
        frame.origin.y = topLayoutGuide + CGRectGetHeight(self.singleTabsView.frame);
    }
    frame.size.width = CGRectGetWidth(self.view.frame);
    frame.size.height = SCREENHEIGHT - (self.hideTab?0:TABSVIEWHEIGHT) - NAVBARHEIGHT - (self.tabBarController.tabBar.hidden ? 0 : CGRectGetHeight(self.tabBarController.tabBar.frame));
    self.contentView.frame = frame;
}

#pragma mark - Interface rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self layoutSubviews];
    
    self.activeTabIndex = self.activeTabIndex;
}

- (void)reloadData
{
    [self defaultSetup];
}

- (void) reloadContents
{
    [self.contents removeAllObjects];
    
    self.contents = [NSMutableArray arrayWithCapacity:self.tabCount];
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        [self.contents addObject:[NSNull null]];
    }
    
    [self selectTabAtIndex:0 noSwipe:NO];
    
}

- (void)defaultSettings {
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    [self addChildViewController:self.pageViewController];
    
    self.actualDelegate = ((UIScrollView *)[self.pageViewController.view.subviews objectAtIndex:0]).delegate;
    
    ((UIScrollView *)[self.pageViewController.view.subviews objectAtIndex:0]).delegate = self;
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.animatingToTab = NO;
    self.hideTab = NO;
}

- (void)defaultSetup {
    
    for (UIView *tabView in self.tabs) {
        [tabView removeFromSuperview];
    }
    self.tabsView.contentSize = CGSizeZero;
    [self.tabsView removeAllSubviews];
    [self.singleTabsView removeAllSubviews];
    
    [self.tabs removeAllObjects];
    [self.contents removeAllObjects];
    [self.titles removeAllObjects];
    
    self.tabCount = [self.delegate numberOfTabsForViewPager:self];
    
    self.tabs = [NSMutableArray arrayWithCapacity:self.tabCount];
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        [self.tabs addObject:[NSNull null]];
    }
    
    self.titles = [NSMutableArray arrayWithCapacity:self.tabCount];
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        [self.titles addObject:[NSNull null]];
    }
    
    self.contents = [NSMutableArray arrayWithCapacity:self.tabCount];
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        [self.contents addObject:[NSNull null]];
    }
    
    //是否可以滑动  默认是NO,可以滑动
    if (!self.noScroll) {
        
        if (!self.tabsView) {
            
            self.tabsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, self.hideNavigationBar ? STATUSBARHEIGHT : NAVBARHEIGHT, CGRectGetWidth(self.view.frame), TABSVIEWHEIGHT)];
            self.tabsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.tabsView.backgroundColor = ZLWhiteColor;
            self.tabsView.scrollsToTop = NO;
            self.tabsView.showsHorizontalScrollIndicator = NO;
            self.tabsView.showsVerticalScrollIndicator = NO;
            self.tabsView.delegate = self;
            [self.view insertSubview:self.tabsView atIndex:0];
            self.tabsView.hidden = self.hideTab;
        }
        
    } else {
        self.singleTabsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.hideNavigationBar ? STATUSBARHEIGHT : NAVBARHEIGHT, CGRectGetWidth(self.view.frame), TABSVIEWHEIGHT)];
        self.singleTabsView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.singleTabsView];
        self.singleTabsView.hidden = self.hideTab;
    }
    
    if (!_bottomLine) {
        UIView *tabView = self.tabsView?self.tabsView:self.singleTabsView;
        self.bottomLine = [[UIView alloc] init];
        self.bottomLine.width = SCREENWIDTH;
        self.bottomLine.height = .5f;
        self.bottomLine.bottom = tabView.height + 0.5;
        self.bottomLine.backgroundColor = ZLGray(209);
        self.bottomLine.hidden = self.hideTab;
        if (!self.noScroll) {
            [self.tabsView addSubview:self.bottomLine];
        }else{
            [self.singleTabsView addSubview:self.bottomLine];
        }
    }
    
    // Add tab views to _tabsView
    CGFloat contentSizeWidth = 0;
    
    CGFloat tabWidth = SCREENWIDTH / self.tabCount;
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        
        UIView *tabView = [self tabViewAtIndex:i];
        
        CGRect frame = tabView.frame;
        
        
        if (!self.noScroll) {
            
            frame.origin.x = contentSizeWidth + 13.5;
            
            tabView.frame = frame;
            tabView.centerY = TABSVIEWHEIGHT / 2;
            
            [self.tabsView addSubview:tabView];
            contentSizeWidth += CGRectGetWidth(tabView.frame) + 30;
        } else {
            frame.size.width = tabWidth - 20;
            tabView.frame = frame;
            tabView.centerX = tabWidth * i + tabWidth / 2;
            tabView.centerY = TABSVIEWHEIGHT / 2;
            
            for (UILabel *titleLabel in tabView.subviews) {
                if (titleLabel) {
                    titleLabel.textColor = ZLGray(153);
                    titleLabel.font = ZLNormalFont(14);
                    [titleLabel sizeToFit];
                    titleLabel.centerX = tabView.width / 2;
                }
            }
            
            [self.singleTabsView addSubview:tabView];
        }
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        tabView.userInteractionEnabled = YES;
        [tabView addGestureRecognizer:tapGestureRecognizer];
    }
    
    self.tabsView.contentSize = CGSizeMake(contentSizeWidth, TABSVIEWHEIGHT);
    
    //颜色条
    if (!_selectedBorder) {
        
        _selectedBorder = [[UIView alloc] initWithFrame:CGRectZero];
        _selectedBorder.height = 1.5;
        _selectedBorder.backgroundColor = _choosedColor ? _choosedColor : ZLRGB(236, 49, 45);
    }
    if (!self.noScroll) {
        _selectedBorder.bottom = self.tabsView.height;
        [self.tabsView addSubview:_selectedBorder];
    } else {
        _selectedBorder.bottom = self.singleTabsView.height;
        [self.singleTabsView addSubview:_selectedBorder];
    }
    
    if (!self.contentView) {
        
        self.contentView = self.pageViewController.view;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.contentView.backgroundColor = self.contentViewBackgroundColor;
        self.contentView.bounds = self.view.bounds;
        
        [self.view insertSubview:self.contentView atIndex:0];
    }
    
    
    [self selectTabAtIndex:0 noSwipe:NO];
    
}

- (UIView *)tabViewAtIndex:(NSUInteger)index {
    
    if (index >= self.tabCount) {
        return nil;
    }
    
    if ([[self.tabs objectAtIndex:index] isEqual:[NSNull null]]) {
        
        UILabel *tabViewContent = [self.delegate viewPager:self tabForTabAtIndex:index];
        tabViewContent.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tabViewContent.width + 10, TABSVIEWHEIGHT)];
        tabViewContent.centerX = tabView.width / 2;
        tabViewContent.centerY = tabView.height / 2;
        [tabView addSubview:tabViewContent];
        
        [self.tabs replaceObjectAtIndex:index withObject:tabView];
    }
    
    return [self.tabs objectAtIndex:index];
}

- (void)handleTapGesture:(id)sender {
    
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIView *tabView = tapGestureRecognizer.view;
    __block NSUInteger index = [self.tabs indexOfObject:tabView];
    
    if (self.activeTabIndex != index) {
        [self selectTabAtIndex:index noSwipe:NO];
    }
}

- (void)selectTabAtIndex:(NSUInteger)index noSwipe:(BOOL)noSwipe {
    
    
    if (index >= self.tabCount) {
        return;
    }
    
    self.animatingToTab = YES;
    
    self.activeTabIndex = index;
    self.activeContentIndex = index;
    
    if (!self.noScroll) {
        
        UIView *tabView = [self tabViewAtIndex:index];
        CGRect frame = tabView.frame;
        
        [UIView animateWithDuration:noSwipe ? 0 : 0.2 animations:^{//noSwipe=yes, 无动画, =no, 有动画
            
            self.tabsView.contentOffset = CGPointMake(frame.origin.x - self.tabsView.width / 2 + frame.size.width / 2, 0);
            
            
            if (self.tabsView.contentOffset.x < 0) {
                self.tabsView.contentOffset = CGPointMake(0, 0);
            }
            
            if (self.tabsView.contentOffset.x > self.tabsView.contentSize.width - self.tabsView.width) {
                self.tabsView.contentOffset = CGPointMake(self.tabsView.contentSize.width - self.tabsView.width, 0);
            }
            
            
            if (self.tabsView.contentOffset.x > 0) {
                self.bgView.hidden = NO;
                if (self.activeTabIndex == 0) {
                    self.firstSelectedBorder.hidden = NO;
                } else {
                    self.firstSelectedBorder.hidden = YES;
                }
                
            }
            else if (self.tabsView.contentOffset.x <= 0) {
                [self performSelector:@selector(bgViewHidden) withObject:nil afterDelay:0.3];
            }
        }];
        
    }
    //移动下划线与动画
    [UIView animateWithDuration:0.2 animations:^{
        [self initSelector];
    }];
    
    if ([self.delegate respondsToSelector:@selector(viewPager:didSelectTabAtIndex:)]) {
        [self.delegate viewPager:self didSelectTabAtIndex:self.activeTabIndex];
    }
    
}

- (void)initSelector
{
    UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
    
    CGFloat width = tabView.width;
    CGFloat selectorWidth = width * 1.2;
    
    _selectedBorder.width = selectorWidth;
    _selectedBorder.centerX = tabView.centerX;
    
    
}

- (void)setActiveTabIndex:(NSUInteger)activeTabIndex {
    
    UIView *activeTabView;
    
    activeTabView = [self tabViewAtIndex:self.activeTabIndex];
    for (UILabel *titleLabel in activeTabView.subviews) {
        if (titleLabel) {
            titleLabel.textColor = ZLGray(153);
            titleLabel.font = ZLNormalFont(14);
            [titleLabel sizeToFit];
            titleLabel.centerX = activeTabView.width / 2;
        }
    }
    
    activeTabView = [self tabViewAtIndex:activeTabIndex];
    for (UILabel *titleLabel in activeTabView.subviews) {
        if (titleLabel) {
            titleLabel.textColor = self.choosedColor ? self.choosedColor : ZLBlackColor;
            titleLabel.font = self.noSelectBold ? ZLNormalFont(14) : ZLNormalFont(16);
            [titleLabel sizeToFit];
            titleLabel.centerX = activeTabView.width / 2;
        }
    }
    
    _activeTabIndex = activeTabIndex;
}

- (void)setActiveContentIndex:(NSUInteger)activeContentIndex {
    
    UIViewController *viewController = [self viewControllerAtIndex:activeContentIndex];
    
    if (!viewController) {
        viewController = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
        viewController.view.backgroundColor = [UIColor clearColor];
    }
    
    weakSelf(self);
    
    if (activeContentIndex == self.activeContentIndex) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.pageViewController setViewControllers:@[viewController]
                                              direction:UIPageViewControllerNavigationDirectionForward
                                               animated:NO
                                             completion:^(BOOL completed) {
                                                 strongSelf(self);
                                                 self.animatingToTab = NO;
                                             }];
        });
    } else if (!(activeContentIndex + 1 == self.activeContentIndex || activeContentIndex - 1 == self.activeContentIndex)) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.pageViewController setViewControllers:@[viewController]
                                              direction:(activeContentIndex < self.activeContentIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward
                                               animated:NO
                                             completion:^(BOOL completed) {
                                                 strongSelf(self);
                                                 
                                                 self.animatingToTab = NO;
                                                 
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     [self.pageViewController setViewControllers:@[viewController]
                                                                                           direction:(activeContentIndex < self.activeContentIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward
                                                                                            animated:NO
                                                                                          completion:nil];
                                                 });
                                             }];
        });
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.pageViewController setViewControllers:@[viewController]
                                              direction:(activeContentIndex < self.activeContentIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward
                                               animated:NO
                                             completion:^(BOOL completed) {
                                                 strongSelf(self);
                                                 
                                                 self.animatingToTab = NO;
                                             }];
        });
        
    }
    
    _activeContentIndex = activeContentIndex;
}



- (void)selectTabAtIndex:(NSUInteger)index {
    [self selectTabAtIndex:index noSwipe:NO];
}

- (void)bgViewHidden {
    if (self.tabsView.contentOffset.x <= 0) {
        self.bgView.hidden = YES;
    }
}

- (void)setHideTab:(BOOL)hideTab
{
    _hideTab = hideTab;
    self.singleTabsView.hidden = _hideTab;
    self.tabsView.hidden = _hideTab;
}

- (NSUInteger)indexForTabView:(UIView *)tabView {
    
    return [self.tabs indexOfObject:tabView];
}

- (NSUInteger)indexForViewController:(UIViewController *)viewController {
    
    return [self.contents indexOfObject:viewController];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (index >= self.tabCount) {
        return nil;
    }
    
    if ([[self.contents objectAtIndex:index] isEqual:[NSNull null]]) {
        
        UIViewController *viewController;
        
        if ([self.delegate respondsToSelector:@selector(viewPager:contentViewControllerForTabAtIndex:)]) {
            viewController = [self.delegate viewPager:self contentViewControllerForTabAtIndex:index];
        } else if ([self.delegate respondsToSelector:@selector(viewPager:contentViewForTabAtIndex:)]) {
            
            UIView *view = [self.delegate viewPager:self contentViewForTabAtIndex:index];
            
            view.frame = self.contentView.bounds;
            
            viewController = [UIViewController new];
            viewController.view = view;
        } else {
            viewController = [[UIViewController alloc] init];
            viewController.view = [[UIView alloc] init];
        }
        
        [self.contents replaceObjectAtIndex:index withObject:viewController];
    }
    
    return [self.contents objectAtIndex:index];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index++;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index--;
    return [self viewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    
    NSUInteger index = [self indexForViewController:viewController];
    [self selectTabAtIndex:index noSwipe:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tabsView) {
        if (scrollView.isDragging) {
            if (scrollView.contentOffset.x <= 0) {
                self.bgView.hidden = YES;
            } else {
                self.bgView.hidden = NO;
                if (self.activeTabIndex == 0) {
                    self.firstSelectedBorder.hidden = NO;
                } else {
                    self.firstSelectedBorder.hidden = YES;
                }
            }
        }
        
    } else {
        
        if ([self.actualDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [self.actualDelegate scrollViewDidScroll:scrollView];
        }
        
    }
}


@end
