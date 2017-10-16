//
//  ItemRebateCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemRebateCell.h"

@interface ItemRebateCell()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation ItemRebateCell

#pragma mark - override
- (void)initCellComponent {
    self.backgroundColor = ZLRGB(255, 246, 246);
    [self cellAddSubview:self.titleLabel];
    [self cellAddSubview:self.contentLabel];
}

- (void)reloadData {
    if (self.cellData) {
        NSString *cashback = (NSString *)self.cellData;
        self.contentLabel.text = cashback;
        self.titleLabel.text = @"商品返利规则";
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        height = 75;
    }
    return @(height);
}

#pragma mark - properties
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = ZLNormalFont(14);
        label.textColor = ZLRedColor;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = ZLNormalFont(14);
        label.textColor = ZLGray(140);
        _contentLabel = label;
    }
    return _contentLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    _titleLabel.left = 12;
    _titleLabel.top = 15;
    
    [_contentLabel sizeToFit];
    _contentLabel.top = _titleLabel.bottom + 4;
    _contentLabel.left = 12;
}

@end
