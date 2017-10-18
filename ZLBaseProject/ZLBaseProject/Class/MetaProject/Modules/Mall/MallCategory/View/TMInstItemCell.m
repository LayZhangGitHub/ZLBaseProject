//
//  TMInstItemCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMInstItemCell.h"
#import "InstItemModel.h"

#define EDGE 15.f
#define ITEM_WIDTH ((SCREENWIDTH - EDGE) / 2)

@interface TMInstItemCell()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *priceLable;

@end

@implementation TMInstItemCell

#pragma mark - override
- (void)reloadData {
    self.backgroundColor = ZLWhiteColor;
    if (self.cellData) {
        InstItemModel *item = (InstItemModel *)self.cellData;
        
        [self cellAddSubview:self.itemImageView];
        [self cellAddSubview:self.titleLable];
        [self cellAddSubview:self.priceLable];
        
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = YES;
        
        self.itemImageView.height = item.image.h / item.image.w * ITEM_WIDTH;
        [self.itemImageView setOnlineImage:item.image.src];
        
        self.titleLable.text = item.title;
        self.priceLable.text = item.price;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        InstItemModel *item = (InstItemModel *)cellData;
        height = item.image.h / item.image.w * ITEM_WIDTH + 50;
    }
    return @(height);
}

+ (NSNumber *)widthForCell:(id)cellData {
    CGFloat width = 0;
    if (cellData) {
        width = ITEM_WIDTH;
    }
    return @(width);
}

#pragma mark - properties
- (UIImageView *)itemImageView {
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ITEM_WIDTH, 0)];
    }
    return _itemImageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = ZLGray(100);
        _titleLable.font = ZLNormalFont(12);
    }
    return _titleLable;
}

- (UILabel *)priceLable {
    if (!_priceLable) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.textColor = ZLRGB(255, 68, 68);
        _priceLable.font = ZLBoldFont(14);
    }
    return _priceLable;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLable sizeToFit];
    _titleLable.width = ITEM_WIDTH - 5; // 显示不全的省略
    _titleLable.left = 5;
    _titleLable.top = _itemImageView.bottom + 5;
    
    [_priceLable sizeToFit];
    _priceLable.width = ITEM_WIDTH - 5;
    _priceLable.top = _titleLable.bottom + 5;
}


@end
