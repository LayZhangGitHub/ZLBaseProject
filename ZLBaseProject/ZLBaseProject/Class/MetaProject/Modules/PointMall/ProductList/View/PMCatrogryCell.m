//
//  PMCatrogryCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PMCatrogryCell.h"
#import "PMCategoryModuleView.h"

#define EDGE 4
#define ITEM_WITH (SCREENWIDTH - 20 - EDGE * 2) / 3.f

@interface PMCatrogryCell()

@property (nonatomic, strong) NSArray *moduleViews;

@end

@implementation PMCatrogryCell

#pragma mark - override

- (void)reloadData {
    if (self.cellData) {
        NSArray *modules = (NSArray*)self.cellData;
        
        for (int i = 0; i < self.moduleViews.count; i++) {
            PMCategoryModuleView *module = self.moduleViews[i];
            [module setPmCatesModel:modules[i]];
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        NSArray *data = cellData;
        height = 20 + ITEM_WITH / 2 * ceil(data.count / 3.0f) + 2 * EDGE;
    }
    return @(height);
}

#pragma mark - properties
- (NSArray* )moduleViews {
    NSArray *modules = self.cellData;
    if (_moduleViews && _moduleViews.count != modules.count) {
        for (UIView *view in _moduleViews) {
            [view removeFromSuperview];
        }
        _moduleViews = nil;
    }
    
    if (!_moduleViews) {
        NSMutableArray *moduleViews = [NSMutableArray arrayWithCapacity:modules.count];
        
        for (int i = 0; i < modules.count; i++) {
            PMCategoryModuleView *moduleView = [[PMCategoryModuleView alloc] init];
            [moduleViews addObject:moduleView];
            [self cellAddSubview:moduleView];
            
            moduleView.layer.cornerRadius = 3;
            moduleView.layer.masksToBounds = YES;
        }
        
        
        _moduleViews = moduleViews;
    }
    return _moduleViews;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0, row = 0, column = 0; i < _moduleViews.count; i++) {
        row = i / 3;
        column = i % 3;
        UIView *view = self.moduleViews[i];
        view.size = CGSizeMake(ITEM_WITH, ITEM_WITH / 2);
        view.left = 10 + (ITEM_WITH + EDGE) * column;
        view.top = 10 + (EDGE + ITEM_WITH / 2) * row;
    }
}

@end
