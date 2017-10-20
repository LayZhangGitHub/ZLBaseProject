//
//  ShopCategoryCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopCategoryCell.h"

#import "ShopTabCateModel.h"

#define CELL_HEIGHT 43

@interface ShopCategoryCell()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation ShopCategoryCell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        
        [self cellAddSubview:self.scrollView];
        NSArray *cates = (NSArray*)self.cellData;
        
        CGFloat left = 10;
        NSInteger selectedIndex = -1;
        for (int i = 0; i < cates.count; i++) {
            ShopTabCateModel *cate = cates[i];
            if (cate.isSelected) {
                selectedIndex = i;
            }
            
            UIButton *button = self.buttons[i];
            button.left = left;
            left += button.width + 10;
            [self.scrollView addSubview:button];
        }
        
        if (selectedIndex != -1) {
            [self selectButtonWithIndex:selectedIndex];
        }
        
        if (left > self.scrollView.width) {
            self.scrollView.contentSize = CGSizeMake(left, 42);
        }
        self.backgroundColor = ZLGray(245);
        
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    NSArray *list = (NSArray*)cellData;
    if (list.count > 0) {
        height = CELL_HEIGHT;
    }
    return @(height);
}

#pragma mark - properties
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 1, SCREENWIDTH, 42)];
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
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
            ShopTabCateModel *tabModel = tabs[i];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 0, 32)];
            [button setTitle:tabModel.name forState:UIControlStateNormal];
            [button setBackgroundColor:ZLWhiteColor];
            button.titleLabel.font = ZLNormalFont(14);
            [button setTitleColor:ZLWhiteColor forState:UIControlStateSelected];
            [button setTitleColor:ZLGray(45) forState:UIControlStateNormal];
            button.layer.cornerRadius = 2.;
            button.layer.masksToBounds = YES;
            [button sizeToFit];
            if (button.width < 66) {
                button.width = 66;
            }else{
                button.width += 20;
            }
            [button addTarget:self action:@selector(handleCateButton:) forControlEvents:UIControlEventTouchUpInside];
            [tabViews addObject:button];
        }
        _buttons = tabViews;
    }
    return _buttons;
}

- (void)setCateButton:(UIButton*)button selected:(BOOL)selected {
    button.selected = selected;
    if (selected) {
        [button setBackgroundColor:ZLRedColor];
    }else{
        [button setBackgroundColor:ZLWhiteColor];
    }
}

- (void)selectButtonWithIndex:(NSInteger)index {
    for (UIButton *button in self.buttons) {
        [self setCateButton:button selected:NO];
    }
    UIButton *button = self.buttons[index];
    [self setCateButton:button selected:YES];
    
    if (self.scrollView.contentSize.width > SCREENWIDTH) {
        CGFloat x = button.left - (SCREENWIDTH - button.width) / 2;
        if (x < 0) {
            x = 0;
        }else if (x > self.scrollView.contentSize.width - SCREENWIDTH) {
            x = self.scrollView.contentSize.width - SCREENWIDTH;
        }
        [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    }
}

- (void)handleCateButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger index = [_buttons indexOfObject:button];
    
    if(button.selected)
        return;
    
    [self selectButtonWithIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(cellTapCate:)]) {
        NSArray *cates = (NSArray *)self.cellData;
        [self.delegate cellTapCate:cates[index]];
    }
}

@end
