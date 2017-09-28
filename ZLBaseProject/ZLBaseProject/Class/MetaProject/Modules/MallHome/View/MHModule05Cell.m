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

#define InstrumentViewWidth 70
#define InstrumentCount 4
#define Top 12
#define Eadge (SCREENWIDTH - InstrumentCount * InstrumentViewWidth) / (InstrumentCount + 1)

@interface MHModule05Cell()

@property (nonatomic, strong) NSMutableArray *moduleViews;

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
            [module reloadData:@{@"title":title,@"icon":image,@"link":link}];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    CGFloat height = 0;
    MHModuleModel *model = cellData;
    if (model.items.count) {
        int row = ceil(model.items.count / (CGFloat)InstrumentCount);
        height = Top + (Top + InstrumentViewWidth) * row;
    }
    return height;
}

#pragma mark - properties
- (NSMutableArray*)moduleViews {
    if (!_moduleViews) {
        
        MHModuleModel *model = self.cellData;
        _moduleViews = [NSMutableArray arrayWithCapacity:model.items.count];
        for (int i = 0; i < model.items.count ; i++) {
            Instrument01View *moduleView = [[Instrument01View alloc] init];
            [_moduleViews addObject:moduleView];
            [self cellAddSubview:moduleView];
        }
    }
    return _moduleViews;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int row = 0, column = 0, i = 0; i < self.moduleViews.count; i++) {
        row = i / InstrumentCount;
        column = i % InstrumentCount;
        UIView *view = self.moduleViews[i];
        view.size = CGSizeMake(70, 70);
        view.left = Eadge + (InstrumentViewWidth + Eadge) * column;
        view.top = Top + (Top + InstrumentViewWidth) * row;
    }
}

@end
