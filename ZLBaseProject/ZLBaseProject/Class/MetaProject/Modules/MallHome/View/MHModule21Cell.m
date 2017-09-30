//
//  MHModule21Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/29.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule21Cell.h"
#import "MHModuleModel.h"
#import "Instrument02View.h"

#define EDGE 12
#define ITEM_WIDTH  ((SCREENWIDTH - EDGE) / 2.0f - EDGE)

@interface MHModule21Cell()
@property (nonatomic, strong) NSArray *moduleViews;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,assign) CGFloat iconHeight;
@end

@implementation MHModule21Cell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        self.backgroundColor = ZLWhiteColor;
        [self cellAddSubview:self.titleLabel];
        
        MHModuleModel *model = self.cellData;
        
        self.titleLabel.text = model.header.title.text;
        
        MHItemModel *first = model.items[0];
        _iconHeight = ITEM_WIDTH / first.ar;
        
        for (int i = 0; i < model.items.count; i++) {
            MHItemModel *item = model.items[i];
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";
            Instrument02View *module = self.moduleViews[i];
            [module setModel:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_w"}];
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        int row = ceil(model.items.count / 2.);
        MHItemModel *item = model.items[0];
        if (item) {
            height = EDGE + (EDGE + ITEM_WIDTH / item.ar) * row + 30;
        }
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

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = ZLNormalFont(16);
        label.textColor = ZLGray(42);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    _titleLabel.left = 12;
    _titleLabel.top = 12;
    
    for (int row,column,i = 0; i < _moduleViews.count; i++) {
        row = i / 2;
        column = i % 2;
        UIView *view = _moduleViews[i];
        view.frame = CGRectMake(EDGE + (ITEM_WIDTH + EDGE) * column, 12 + (12 + _iconHeight) * row + 30,
                                ITEM_WIDTH, _iconHeight);
    }
}

@end
