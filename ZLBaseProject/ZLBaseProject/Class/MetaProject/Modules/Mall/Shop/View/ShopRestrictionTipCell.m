//
//  ShopRestrictionTipCell.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopRestrictionTipCell.h"

@interface ShopRestrictionTipCell()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *tipImageView;
@property (nonatomic,strong) UILabel *tipLabel;

@end

@implementation ShopRestrictionTipCell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        [self cellAddSubview:self.bgView];
        [self cellAddSubview:self.tipImageView];
        [self cellAddSubview:self.tipLabel];
        
        NSString *tip = (NSString *)self.cellData;
        self.tipLabel.text = tip;
        [self.tipLabel sizeToFit];
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        height = 48;
    }
    return @(height);
}

#pragma mark - override
- (UIView *)bgView {
    if (!_bgView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 38)];
        view.backgroundColor = ZLWhiteColor;
        _bgView = view;
    }
    return _bgView;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
        imageView.image = [UIImage imageNamed:@"icon_ restriction_tip"];
        [imageView sizeToFit];
        imageView.centerY = 19;
        _tipImageView = imageView;
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = ZLNormalFont(12);
        label.textColor = ZLGray(62);
        label.text = @"每人限购10件";
        [label sizeToFit];
        label.centerY = self.tipImageView.centerY;
        label.left = self.tipImageView.right + 3;
        _tipLabel = label;
    }
    return _tipLabel;
}
@end
