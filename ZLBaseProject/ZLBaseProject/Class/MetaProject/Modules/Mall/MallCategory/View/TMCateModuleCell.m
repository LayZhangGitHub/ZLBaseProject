//
//  TMCateModuleCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMCateModuleCell.h"
#import "TMCateModuleView.h"

#import "TMCateModuleModel.h"

#define MODULEVIEW_WIDTH 66
#define MODULEVIEW_HEIGHT 110
#define EDGE (SCREENWIDTH - MODULEVIEW_WIDTH * 4) / 5

@interface TMCateModuleCell()

@property (nonatomic, strong) NSMutableArray *moduleViews;

@end

@implementation TMCateModuleCell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray *modules = self.cellData;
        
        for (int i = 0; i < modules.count; i++) {
            TMCateModuleView *moduleView = self.moduleViews[i];
            [self cellAddSubview:moduleView];
            moduleView.model = modules[i];
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        NSArray *modules = cellData;

        if (modules.count == 0) {
            height = 0;
        } else {
            height = 18 * 2 + (110) * ceil(modules.count / 4.);
        }
    }
    return @(height);
}

- (NSMutableArray *)moduleViews {
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
            TMCateModuleView *moduleView = [[TMCateModuleView alloc] init];
            [moduleViews addObject:moduleView];
        }
        _moduleViews = moduleViews;
    }
    return _moduleViews;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0,row = 0,column = 0; i < _moduleViews.count; i++) {
        row = i /4;
        column = i % 4;
        TMCateModuleView *moduleView = _moduleViews[i];
        moduleView.size = CGSizeMake(MODULEVIEW_WIDTH, MODULEVIEW_HEIGHT);
        moduleView.left = EDGE + (MODULEVIEW_WIDTH + EDGE) * column;
        moduleView.top = 18 + MODULEVIEW_HEIGHT * row;
    }
}


@end
