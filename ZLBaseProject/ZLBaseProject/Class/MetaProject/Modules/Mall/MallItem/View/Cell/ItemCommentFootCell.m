//
//  ItemCommentFootCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemCommentFootCell.h"

@interface ItemCommentFootCell()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ItemCommentFootCell

#pragma mark - override
- (void)initCellComponent {
    self.backgroundColor = ZLWhiteColor;
    [self addSubview:self.line];
    [self addSubview:self.titleLabel];
}

- (void)reloadData {
    //
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        height = 40;
    }
    return @(height);
}

#pragma mark - properties
- (UIView *)line {
    if (!_line) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZLGray(238);
        _line = view;
    }
    return _line;
}

- (UILabel*)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = ZLNormalFont(14);
        label.textColor = ZLGray(66);
        label.text = @"查看全部评论";
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _line.frame = CGRectMake(0, 0, self.width, LINEWIDTH);
    
    [_titleLabel sizeToFit];
    _titleLabel.centerX = self.width / 2;
    _titleLabel.centerY = self.height / 2;
}

@end
