//
//  MineMenuCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MineMenuCell.h"

@interface MineMenuCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic,strong) UILabel *valueLabel;

@end

@implementation MineMenuCell

#pragma mark - override
- (void)initCellComponent {
    self.backgroundColor = ZLWhiteColor;
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.moreImageView];
    [self addSubview:self.valueLabel];
}

- (void)reloadData{
    
    if (self.cellData) {
        
        NSDictionary *itemData = (NSDictionary *)self.cellData;
        NSString *iconName = itemData[@"icon"];
        
        if ([iconName isNotEmptyString]) {
            self.iconImageView.image = [UIImage imageNamed:itemData[@"icon"]];
            [self.iconImageView sizeToFit];
            self.iconImageView.centerX = 29;
        } else {
            self.iconImageView.hidden = YES;
        }
        
        self.titleLabel.text = itemData[@"title"];
        [self.titleLabel sizeToFit];
        if ([iconName isNotEmptyString]) {
            self.titleLabel.left = self.iconImageView.right + 13;
        } else {
            self.titleLabel.left = 20;
        }
        self.titleLabel.centerY = 22.5;
        
        if ([itemData[@"line"] boolValue]) {
            self.lineView.hidden = NO;
        } else {
            self.lineView.hidden = YES;
        }
        
        if ([itemData[@"arrow"] boolValue]) {
            self.moreImageView.hidden = NO;
        } else {
            self.moreImageView.hidden = YES;
        }
        
        self.valueLabel.text = itemData[@"value"];
        [self.valueLabel sizeToFit];
        self.valueLabel.centerY = 22.5;
        self.valueLabel.right = self.moreImageView.left - 5;
        
        if ([self.titleLabel.text isEqualToString:@"居住地"]) {
            self.valueLabel.textColor = ZLGray(186);
            self.valueLabel.right = self.moreImageView.right;
        }else {
            self.valueLabel.textColor = ZLRedColor;
        }
        if (self.valueLabel.left < self.titleLabel.right - 10) {
            self.valueLabel.width = self.moreImageView.left - 15 - self.titleLabel.right;
            self.valueLabel.right = self.moreImageView.left - 5;
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        NSDictionary *itemData = (NSDictionary *)cellData;
        if ([@"empty" isEqualToString:itemData[@"type"]]) {
            height = 15;
        } else {
            height = 45;
        }
    }
    return @(height);
}

#pragma mark - Getters And Setters

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 18, 18)];
        _iconImageView.centerY = 22.5;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.textColor = ZLGray(42);
        _titleLabel.font = ZLNormalFont(16);
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _valueLabel.textColor = ZLRedColor;
        _valueLabel.font = ZLNormalFont(16);
        _valueLabel.numberOfLines=1;
    }
    return _valueLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREENWIDTH - 13 * 2, LINEWIDTH)];
        _lineView.backgroundColor = ZLGray(230);
        _lineView.bottom = 45;
    }
    return _lineView;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = 22.5;
        _moreImageView.right = SCREENWIDTH - 15;
    }
    return _moreImageView;
}

@end
