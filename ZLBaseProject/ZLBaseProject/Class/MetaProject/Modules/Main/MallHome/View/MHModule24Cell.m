//
//  MHModule24Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/29.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule24Cell.h"
#import "Instrument03View.h"

#import "MHModuleModel.h"

#define EDGE 12
#define ICONVIEW_WIDTH 64

@interface MHModule24Cell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSArray *moduleViews;

@property (nonatomic, assign) CGFloat iconHeight;

@end

@implementation MHModule24Cell


#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        self.backgroundColor = ZLWhiteColor;
        [self cellAddSubview:self.scrollView];
        [self cellAddSubview:self.titleLabel];
        [self cellAddSubview:self.descLabel];
        
        MHModuleModel *model = self.cellData;
        
        if (model.header) {
            self.titleLabel.text = model.header.title.text;
            
            self.descLabel.text = model.header.title.desc;
        } else {
            self.titleLabel.text = @"";
            self.descLabel.text = @"";
        }
        
        MHItemModel *item = [model.items objectAtIndex:0];
        if (item) {
            _iconHeight = ICONVIEW_WIDTH / item.ar + 30;
            self.scrollView.hidden = NO;
        } else {
            self.scrollView.hidden = YES;
        }
        
        for (int i = 0; i < model.items.count; i++) {
            MHItemModel *item = model.items[i];
            NSDictionary *itemDic = [self translateFrom:item];
            Instrument03View *moduleView = self.moduleViews[i];
            [moduleView setModel:itemDic];
        }
        self.scrollView.contentSize = CGSizeMake((ICONVIEW_WIDTH + EDGE) * model.items.count + EDGE, self.scrollView.height);
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        if (model.header) {
            height += 30;
        }
        MHItemModel *item = model.items[0];
        if (item) {
            height += 12 + ICONVIEW_WIDTH / item.ar + 30 + EDGE;
        }
    }
    return @(height);
}

#pragma mark - properties
- (NSDictionary *)translateFrom:(MHItemModel *)item {
    return @{
             @"title":item.title,
             @"icon":item.image,
             @"link":item.link ? item.link : @"",
             @"iconWidth":@(ICONVIEW_WIDTH),
             @"iconHeight":@(ICONVIEW_WIDTH / item.ar),
             @"placeholder":@"placeholder_h"};
}

- (NSArray *)moduleViews {
    
    MHModuleModel *model = self.cellData;
    if (_moduleViews && _moduleViews.count != model.items.count) {
        for (UIView *view in _moduleViews) {
            [view removeFromSuperview];
        }
        _moduleViews = nil;
    }
    
    if (!_moduleViews) {
        NSMutableArray *modules = [NSMutableArray new];
        for (int i = 0; i < model.items.count; i++) {
            Instrument03View *modulesView = [[Instrument03View alloc] init];
            modulesView.font = ZLNormalFont(16);
            modulesView.textAlignment = NSTextAlignmentCenter;
            [modules addObject:modulesView];
            [self.scrollView addSubview:modulesView];
        }
        _moduleViews = [NSArray arrayWithArray:modules];
    }
    return _moduleViews;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = ZLNormalFont(20);
        label.textColor = ZLGray(100);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = ZLNormalFont(14);
        label.textColor = ZLGray(153);
        label.userInteractionEnabled = YES;
        weakSelf(self);
        [label bk_whenTapped:^{
            strongSelf(self);
            MHHeaderModel *header = ((MHModuleModel *)self.cellData).header;
            [[ZLNavigationService sharedService] openUrl:header.more.link];
        }];
        _descLabel = label;
    }
    return _descLabel;
}

- (UIScrollView*)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = ZLWhiteColor;
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    MHModuleModel *model = self.cellData;
    if (model.header) {
        [_titleLabel sizeToFit];
        _titleLabel.top = 12;
        _titleLabel.left = 12;
        
        [_descLabel sizeToFit];
        _descLabel.centerY = _titleLabel.centerY;
        _descLabel.left = _titleLabel.right + 4;
        
        _scrollView.top = 30 + 12;
    } else {
        _scrollView.top = 12;
    }
    
    if (_moduleViews.count) {
        _scrollView.size = CGSizeMake(SCREENWIDTH, _iconHeight);
    }
    
    // images layout
    for (int i = 0; i < _moduleViews.count; i++) {
        UIView *view = _moduleViews[i];
        [view setFrame:CGRectMake((ICONVIEW_WIDTH + EDGE) * i + EDGE, 0, ICONVIEW_WIDTH, _iconHeight)];
    }
}


@end
