//
//  ShopSiftCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopSiftCell.h"
#import "ShopTabModel.h"

#define CELL_HEIGHT 44

@interface ShopSiftCell()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *cellLine;

@end

@implementation ShopSiftCell

#pragma mark - override

- (void)reloadData {
    if (self.cellData) {
        NSArray *tabs = (NSArray*)self.cellData;
        CGFloat buttonWidth = SCREENWIDTH / tabs.count;
        self.bottomLine.width = buttonWidth;
        
        NSInteger selectedIndex = -1;
        
        for (int i = 0; i < tabs.count; i++) {
            ShopTabModel *tab = tabs[i];
            if (tab.isSelected) {
                selectedIndex = i;
            }
            UIButton *button = self.buttons[i];
            button.width = buttonWidth;
            button.left = i * buttonWidth;
            [self cellAddSubview:button];
        }
        
        if (selectedIndex != -1) {
            [self selectTabWithIndex:selectedIndex completion:nil];
        }
        
        [self cellAddSubview:self.cellLine];
        [self cellAddSubview:self.bottomLine];
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        height = CELL_HEIGHT;
    }
    return @(height);
}

#pragma mark - properties
- (UIView *)bottomLine {
    if (!_bottomLine) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 2 * LINEWIDTH)];
        view.backgroundColor = ZLRedColor;
        view.bottom = 44;
        _bottomLine = view;
    }
    return _bottomLine;
}

- (UIView *)cellLine {
    if (!_cellLine) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, LINEWIDTH)];
        view.backgroundColor = ZLGray(238);
        view.bottom = 44;
        _cellLine = view;
    }
    return _cellLine;
}

- (NSMutableArray *)buttons {
    NSArray *tabs = (NSArray*)self.cellData;
    if (_buttons && _buttons.count != tabs.count) {
        for (UIView *view in _buttons) {
            [view removeFromSuperview];
        }
        _buttons = nil;
    }
    
    if (!_buttons) {
        NSMutableArray *tabViews = [NSMutableArray arrayWithCapacity:tabs.count];
        for (int i = 0; i < tabs.count; i++) {
            ShopTabModel *tabModel = tabs[i];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 42)];
            [button setTitle:tabModel.name forState:UIControlStateNormal];
            [button setTitleColor:ZLRedColor forState:UIControlStateSelected];
            [button setTitleColor:ZLGray(153) forState:UIControlStateNormal];
            [button setBackgroundColor:ZLWhiteColor];
            button.titleLabel.font = ZLNormalFont(14);
            [button addTarget:self action:@selector(handleTabButton:) forControlEvents:UIControlEventTouchUpInside];
            [tabViews addObject:button];
        }
        _buttons = tabViews;
    }
    return _buttons;
}

#pragma mark - event handler
- (void)handleTabButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger index = [_buttons indexOfObject:button];
    
    if(button.selected)
        return;
    
    weakSelf(self);
    [self selectTabWithIndex:index completion:^{
        strongSelf(self);
        if ([self.delegate respondsToSelector:@selector(cellTapSift:)]) {
            NSArray *tabs = (NSArray*)self.cellData;
            [self.delegate cellTapSift:tabs[index]];
        }
    }];
}

- (void)selectTabWithIndex:(NSInteger)index completion:(void (^)(void))completion {
    for (UIButton *button in self.buttons) {
        button.selected = NO;
    }
    UIButton *button = self.buttons[index];
    button.selected = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLine.left = index * self.bottomLine.width;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

@end
