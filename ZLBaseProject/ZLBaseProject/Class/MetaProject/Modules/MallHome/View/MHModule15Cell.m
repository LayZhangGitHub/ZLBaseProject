//
//  MHModule15Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/29.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule15Cell.h"
#import "Instrument03View.h"
#import "MHModuleModel.h"

#define Edge 12
#define ICONWIDTH 115

@interface MHModule15Cell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) NSArray *moduleViews;

@property (nonatomic, assign) CGFloat iconHeight;

@end

@implementation MHModule15Cell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        self.backgroundColor = ZLWhiteColor;
        [self cellAddSubview:self.scrollView];
        [self cellAddSubview:self.lineView];
        [self cellAddSubview:self.titleLabel];
        [self cellAddSubview:self.descLabel];
        [self cellAddSubview:self.moreImageView];
        
        MHModuleModel *model = self.cellData;
        
        if (model.header) {
            self.titleLabel.text = model.header.title.text;
            self.lineView.backgroundColor = ZLHEX(model.header.bar.color);
            self.lineView.hidden = NO;
            
            self.descLabel.text = model.header.more.text;
        } else {
            self.titleLabel.text = @"";
            self.descLabel.text = @"";
            self.lineView.hidden = YES;
            self.moreImageView.hidden = YES;
        }
        
        MHItemModel *item = [model.items objectAtIndex:0];
        if (item) {
            _iconHeight = ICONWIDTH / item.ar + 30;
            self.scrollView.hidden = NO;
        } else {
            self.scrollView.hidden = YES;
        }
        
        if (_moduleViews.count != model.items.count) {
            [self.scrollView removeAllSubviews];
            _moduleViews = nil;
        }
        
        
        for (int i = 0; i < model.items.count; i++) {
            MHItemModel *item = model.items[i];
            NSDictionary *itemDic = [self translateFrom:item];
            Instrument03View *moduleView = self.moduleViews[i];
            [moduleView setModel:itemDic];
        }
        self.scrollView.contentSize = CGSizeMake((ICONWIDTH + Edge) * model.items.count + Edge, self.scrollView.height);
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        if (model.header) {
            height += 45;
        }
        MHItemModel *item = model.items[0];
        if (item) {
            height += ICONWIDTH / item.ar + 30 + Edge;
        }
        height += Edge;
    }
    return @(height);
}

#pragma mark - properties
- (NSDictionary *)translateFrom:(MHItemModel *)item {
    return @{
             @"title":item.title,
             @"icon":item.image,
             @"link":item.link ? item.link : @"",
             @"iconWidth":@(ICONWIDTH),
             @"iconHeight":@(ICONWIDTH / item.ar),
             @"placeholder":@"placeholder_h"};
}

- (NSArray *)moduleViews {
    if (!_moduleViews) {
        NSMutableArray *modules = [NSMutableArray new];
        
        MHModuleModel *model = self.cellData;
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

- (UIView *)lineView {
    if (!_lineView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZLRGB(255, 216, 86);
        _lineView = view;
    }
    return _lineView;
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


- (UIImageView *)moreImageView {
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
    }
    return _moreImageView;
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
        _lineView.frame = CGRectMake(12, 18, 2, 15);
        [_titleLabel sizeToFit];
        _titleLabel.centerY = _lineView.centerY;
        _titleLabel.left = _lineView.right + 12;
        
        _moreImageView.frame = CGRectMake(0, 0, 7, 13);
        _moreImageView.centerY = self.titleLabel.centerY;
        _moreImageView.right = self.right - 15;
        
        [_descLabel sizeToFit];
        _descLabel.centerY = _titleLabel.centerY;
        _descLabel.right = _moreImageView.left - 4;
        
        _scrollView.top = 45 + 12;
    } else {
        _scrollView.top = 12;
    }
    
    if (_moduleViews.count) {
        _scrollView.size = CGSizeMake(SCREENWIDTH, _iconHeight);
    }
    
    // images layout
    for (int i = 0; i < _moduleViews.count; i++) {
        UIView *view = _moduleViews[i];
        [view setFrame:CGRectMake((ICONWIDTH + Edge) * i + Edge, 0, ICONWIDTH, _iconHeight)];
    }
}

@end
