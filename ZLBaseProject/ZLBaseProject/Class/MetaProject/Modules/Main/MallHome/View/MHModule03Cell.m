//
//  MHModule03Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule03Cell.h"
#import "MHModuleModel.h"
#import "Instrument02View.h"

#define EDGE 12

@interface MHModule03Cell()

@property (nonatomic, strong) NSMutableArray *moduleViews;
@property (nonatomic, assign) CGFloat iconHeight;

@end

@implementation MHModule03Cell

#pragma mark - override
- (void)reloadData {
    
    if (self.cellData) {
        self.backgroundColor = ZLWhiteColor;
        
        MHModuleModel *model = self.cellData;
        
        MHItemModel *firstItem = model.items[0];
        CGFloat width = (SCREENWIDTH - EDGE) / 2.0f - EDGE;
        _iconHeight = width / firstItem.ar;
        for (int i = 0; i < model.items.count; i++) {
            MHItemModel *item = model.items[i];
            NSString *link = item.link ? item.link:@"";
            NSString *image = item.image ? item.image:@"";
            
            Instrument02View *module = self.moduleViews[i];
            module.model = @{@"icon":image,@"link":link,@"placeholder":@"placeholder_w"};
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    MHModuleModel *model = cellData;
    if (model.items.count) {
        int row = ceil(model.items.count / 2.);
        MHItemModel *item = model.items[0];
        CGFloat width = (SCREENWIDTH - EDGE) / 2.0f - EDGE;
        height = EDGE + (EDGE + width / item.ar) * row ;
    }
    return @(height);
}

#pragma mark - properties
- (NSArray* )moduleViews {
    MHModuleModel *model = self.cellData;
    if (_moduleViews && _moduleViews.count != model.items.count) {
        for (UIView *view in _moduleViews) {
            [view removeFromSuperview];
        }
        _moduleViews = nil;
    }
    
    if (!_moduleViews) {
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:model.items.count];
        for (int i = 0; i < model.items.count; i++) {
            Instrument02View *moduleView = [[Instrument02View alloc] init];
            [modules addObject:moduleView];
            [self cellAddSubview:moduleView];
        }
        
        _moduleViews = modules;
    }
    return _moduleViews;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"height %f", _iconHeight);
    CGFloat width = (self.width - EDGE) / 2.0f - EDGE;
    for (int i = 0, row = 0, column = 0; i< _moduleViews.count; i++) {
        row = i / 2;
        column = i % 2;
        UIView *view = self.moduleViews[i];
        view.size = CGSizeMake(width, _iconHeight);
        view.top = EDGE + (EDGE + _iconHeight) * row;
        view.left = EDGE + (width + EDGE) * column;
    }
}


@end
