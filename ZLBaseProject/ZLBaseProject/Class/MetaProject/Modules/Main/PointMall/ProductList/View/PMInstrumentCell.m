//
//  PMInstrumentCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PMInstrumentCell.h"
#import "PMInstrumentView.h"

#define EDGE 5.f
#define ICON_WIDTH ((SCREENWIDTH - 3 * EDGE) / 2)

@interface PMInstrumentCell()

@property (nonatomic, strong) PMInstrumentView *leftItemView;
@property (nonatomic, strong) PMInstrumentView *rightItemView;
@property (nonatomic,strong) NSMutableArray *modules;

@end
@implementation PMInstrumentCell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        [self cellAddSubview:self.leftItemView];
        [self cellAddSubview:self.rightItemView];
        
        NSMutableDictionary *items = (NSMutableDictionary *)self.cellData;
        [self.leftItemView setPmItemModel:items[@"leftItem"]];
        [self.rightItemView setPmItemModel:items[@"rightItem"]];
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        NSMutableDictionary *items = (NSMutableDictionary *)cellData;
        PMItemModel *itemModel = [items objectForKey:@"leftItem"];
        if (itemModel) {
            height = (ICON_WIDTH / itemModel.ar + 60) ;
        }
    }
    return @(height);
}

#pragma mark - Getters And Setters

- (PMInstrumentView *)leftItemView {
    if (!_leftItemView) {
        _leftItemView = [[PMInstrumentView alloc] init];
    }
    return _leftItemView;
}

- (PMInstrumentView *)rightItemView {
    if ( !_rightItemView ) {
        _rightItemView = [[PMInstrumentView alloc] init];
    }
    return _rightItemView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cellHeight = 0;
    if (self.cellData) {
        NSMutableDictionary *items = (NSMutableDictionary *)self.cellData;
        PMItemModel *model = [items objectForKey:@"leftItem"];
        cellHeight = ICON_WIDTH / model.ar;
    }
    
    _leftItemView.frame = CGRectMake(EDGE, 0, ICON_WIDTH, cellHeight);
    _rightItemView.frame = CGRectMake(EDGE * 2 + ICON_WIDTH, 0, ICON_WIDTH, cellHeight);
}

@end
