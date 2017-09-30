//
//  MHModule05Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule05Cell.h"
#import "Instrument01View.h"
#import "MHModuleModel.h"

#define INSTRUMENTVIEW_WIDTH 70
#define INSTRUMENT_COUNT 4
#define TOP 12
#define EDGE ((SCREENWIDTH - INSTRUMENT_COUNT * INSTRUMENTVIEW_WIDTH) / (INSTRUMENT_COUNT + 1))

@interface MHModule05Cell()

@property (nonatomic, strong) NSArray *moduleViews;

@end

@implementation MHModule05Cell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        self.backgroundColor = ZLWhiteColor;
        
        MHModuleModel *model = self.cellData;
        
        for (int i = 0; i<model.items.count ; i++) {
            MHItemModel *item = [model.items objectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *title = item.title?item.title:@"";
            NSString *image = item.image?item.image:@"";
            
            Instrument01View *module = [self.moduleViews objectAtIndex:i];
            [module setModel:@{@"title":title,@"icon":image,@"link":link}];
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    MHModuleModel *model = cellData;
    if (model.items.count) {
        int row = ceil(model.items.count / (CGFloat)INSTRUMENT_COUNT);
        height = TOP + (TOP + INSTRUMENTVIEW_WIDTH) * row;
    }
    return @(height);
}

#pragma mark - properties
- (NSArray *)moduleViews {
    
    MHModuleModel *model = self.cellData;
    if (_moduleViews && _moduleViews.count != model.items.count) {
        for (UIView *view in _moduleViews) {
            [view removeFromSuperview];
        }
        _moduleViews = nil;
    }
    
    if (!_moduleViews) {
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:model.items.count];
        for (int i = 0; i < model.items.count ; i++) {
            Instrument01View *moduleView = [[Instrument01View alloc] init];
            [models addObject:moduleView];
            [self cellAddSubview:moduleView];
        }
        _moduleViews = [NSArray arrayWithArray:models];
    }
    return _moduleViews;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int row = 0, column = 0, i = 0; i < self.moduleViews.count; i++) {
        row = i / INSTRUMENT_COUNT;
        column = i % INSTRUMENT_COUNT;
        UIView *view = self.moduleViews[i];
        view.size = CGSizeMake(70, 70);
        view.left = EDGE + (INSTRUMENTVIEW_WIDTH + EDGE) * column;
        view.top = TOP + (TOP + INSTRUMENTVIEW_WIDTH) * row;
    }
}

@end
