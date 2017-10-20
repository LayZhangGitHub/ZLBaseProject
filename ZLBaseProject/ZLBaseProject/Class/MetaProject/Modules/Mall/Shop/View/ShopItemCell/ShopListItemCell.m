//
//  ShopListItemCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShopListItemCell.h"
#import "ShopItemDetailModel.h"

#define EDGE 15.
#define IMAGE_WIDTH (SCREENWIDTH * 3 / 10.)
#define DESC_WIDTH  (SCREENWIDTH - IMAGE_WIDTH - 3 * EDGE)

@interface ShopListItemCell()

@property (nonatomic, strong) UIView *cellLine;

@end

@implementation ShopListItemCell

#pragma mark - override

- (void)reloadData {
    
    if (self.cellData) {
        
        ShopItemDetailModel *model = (ShopItemDetailModel *)self.cellData;
        
        [self.contentView addSubview:self.itemImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.cellLine];
        
        self.itemImageView.left = 5;
        self.itemImageView.top = 5;
        self.itemImageView.width = IMAGE_WIDTH;
        self.itemImageView.height = IMAGE_WIDTH / model.ar;
        [self.itemImageView setOnlineImage:model.image];
        
        self.titleLabel.text = model.name;
        self.titleLabel.numberOfLines = 2;
        CGSize textSize = [model.name boundingRectWithSize:CGSizeMake( DESC_WIDTH, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: ZLNormalFont(14)} context:nil].size;
        
        self.titleLabel.height = textSize.height;
        self.titleLabel.width = DESC_WIDTH;
        self.titleLabel.top = 10;
        self.titleLabel.left = self.itemImageView.right + EDGE;
        
        self.priceLabel.text = model.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.width = DESC_WIDTH;
        self.priceLabel.bottom = self.itemImageView.bottom;
        self.priceLabel.left = self.itemImageView.right + EDGE;
        
        self.favButton.selected = model.isFav;
        
        self.cellLine.bottom = [[[self class]heightForCell:self.cellData] floatValue];
        
        self.backgroundColor = ZLWhiteColor;
    }else{
        [self removeAllSubviews];
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        ShopItemDetailModel *model = (ShopItemDetailModel *)cellData;
        height = IMAGE_WIDTH / model.ar + 15;
    }
    return @(height);
}

+ (NSNumber *)widthForCell:(id)cellData {
    CGFloat width = 0;
    if (cellData) {
        width = SCREENWIDTH;
    }
    return  @(width);
}

#pragma mark - override
- (UIView *)cellLine {
    if (!_cellLine) {
        _cellLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 10, LINEWIDTH)];
    }
    return _cellLine;
}

@end
