//
//  PMTitleHeaderCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PMTitleHeaderCell.h"


#define TITLEHEADERCELL_HEIGHT 62
#define BGVIEW_HEIGHT 52

@interface PMTitleHeaderCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation PMTitleHeaderCell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        [self cellAddSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        
        NSString *title = self.cellData;
        self.titleLabel.text = title;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        height = TITLEHEADERCELL_HEIGHT;
    }
    return @(height);
}

#pragma mark - properties
- (UIView *)bgView {
    if (!_bgView ) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZLWhiteColor;
        _bgView = view;
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = ZLNormalFont(16);
        label.textColor = ZLGray(100);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bgView.frame = CGRectMake(0, 0, self.width, BGVIEW_HEIGHT);
    
    [_titleLabel sizeToFit];
    self.titleLabel.centerY = _bgView.centerY;
    self.titleLabel.left = 12;
}

@end
