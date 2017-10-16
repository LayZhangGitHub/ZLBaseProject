//
//  ItemTipsCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemTipsCell.h"

@interface ItemTipsCell()

@property (nonatomic,strong) UIImageView *tipImageView;
@property (nonatomic,strong) UILabel *tipLabel;

@end

@implementation ItemTipsCell

- (void)initCellComponent {
    self.backgroundColor = ZLWhiteColor;
    [self cellAddSubview:self.tipImageView];
    [self cellAddSubview:self.tipLabel];
}

- (void)reloadData {
    if (self.cellData) {
        NSString *tip = self.cellData;
        self.tipLabel.text = tip;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        height = 38;
    }
    return @(height);
}

#pragma mark - Subviews
- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 18, 18)];
        imageView.image = [UIImage imageNamed:@"icon_ restriction_tip"];
        _tipImageView = imageView;
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = ZLNormalFont(12);
        label.textColor = ZLGray(62);
        _tipLabel = label;
    }
    return _tipLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _tipImageView.centerY = self.height / 2;
    _tipImageView.left = 10;
    
    [_tipLabel sizeToFit];
    _tipLabel.left = _tipImageView.right + 5;
    _tipLabel.centerY = self.height / 2;
}

@end
