//
//  MHModule04Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule04Cell.h"
#import "Instrument02View.h"
#import "MHModuleModel.h"

#define Edge 12
#define InstrumentViewWidth ((SCREENWIDTH - Edge) / 3 - Edge)
#define InstrumentCount 3


@interface MHModule04Cell()

@property (nonatomic, strong) NSArray *moduleViews;
@property (nonatomic, assign) CGFloat iconHeight;

@end

@implementation MHModule04Cell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        self.backgroundColor = ZLWhiteColor;
        MHModuleModel *model = self.cellData;
        MHItemModel *firstItem = [model.items objectAtIndex:0];
        
        _iconHeight = InstrumentViewWidth / firstItem.ar ;
        
        if (self.moduleViews.count != model.items.count) {
            for (UIView *view in _moduleViews) {
                [view removeFromSuperview];
            }
            _moduleViews = nil;
        }
        
        for (int i = 0; i < model.items.count; i++) {
            MHItemModel *item = [model.items objectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";
            Instrument02View *module = [self.moduleViews objectAtIndex:i];
            [module setModel:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_h"}];
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    MHModuleModel *model = cellData;
    if (model.items.count) {
        MHItemModel *item = [model.items objectAtIndex:0];
        CGFloat width = (SCREENWIDTH - Edge) / InstrumentCount - Edge;
        int row = ceil(model.items.count / (CGFloat)InstrumentCount);
        height = Edge + (width / item.ar + Edge) * row;
    }
    return @(height);
}

- (NSArray* )moduleViews {
    if (!_moduleViews) {
        MHModuleModel *model = self.cellData;
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:model.items.count];
        for (int i = 0; i < model.items.count; i++) {
            Instrument02View *moduleView = [[Instrument02View alloc] init];
            [modules addObject:moduleView];
            [self cellAddSubview:moduleView];
        }
        
        _moduleViews = [NSArray arrayWithArray:modules];
    }
    return _moduleViews;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int row = 0, column = 0, i = 0; i < self.moduleViews.count; i++) {
        row = i / InstrumentCount;
        column = i % InstrumentCount;
        UIView *view = self.moduleViews[i];
        view.size = CGSizeMake(InstrumentViewWidth, _iconHeight);
        view.left = Edge + (InstrumentViewWidth + Edge) * column;
        view.top = Edge + (Edge + _iconHeight) * row;
    }
}

@end
