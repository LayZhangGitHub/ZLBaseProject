//
//  ItemContentHeadCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemContentHeadCell.h"

@interface ItemContentHeadCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ItemContentHeadCell

#pragma mark - override
- (void)initCellComponent {
    self.backgroundColor = ZLWhiteColor;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
}

- (void)reloadData {
}

+ (NSNumber *)heightForCell:(id)cellData {
    return @40;
}

#pragma mark - Getters And Setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = ZLGray(17);
        _titleLabel.font = ZLNormalFont(14);
        _titleLabel.text = @"图文详情";
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, LINEWIDTH)];
        _lineView.backgroundColor = ZLGray(230);
    }
    return _lineView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    _titleLabel.left = 10;
    _titleLabel.top = 13;
    
    _lineView.top = self.width - LINEWIDTH;
}
@end
