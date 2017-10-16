//
//  ItemInfoCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemInfoCell.h"
#import "ItemInfoModel.h"

@interface ItemInfoCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oPriceLabel;
@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *discountInfoLabel;
@property (nonatomic, strong) UILabel *salesLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UILabel *servivePrice;

@end

@implementation ItemInfoCell

#pragma mark - override
- (void)initCellComponent {
    self.backgroundColor = ZLWhiteColor;
    
    [self cellAddSubview:self.titleLabel];
    [self cellAddSubview:self.descLabel];
    [self cellAddSubview:self.priceLabel];
    [self cellAddSubview:self.oPriceLabel];
    [self cellAddSubview:self.discountLabel];
    [self cellAddSubview:self.shareLabel];
    [self cellAddSubview:self.shareButton];
    [self cellAddSubview:self.line];
    [self cellAddSubview:self.discountInfoLabel];
    [self cellAddSubview:self.salesLabel];
    [self cellAddSubview:self.addressLabel];
    
    [self cellAddSubview:self.servivePrice];
}

- (void)reloadData {
    if ( self.cellData ) {
        
        ItemInfoModel *itemInfo = (ItemInfoModel *)self.cellData;
        //itemInfo.title = @"世纪街时间冻结附近附近方法开发开放开发开放开发开放开发开放开发急急急扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩";
        //itemInfo.title = @"世纪";
        //itemInfo.oPrice = @"$1800.00";
        //itemInfo.discount = @"手机专享";
        
        self.titleLabel.text = itemInfo.title;
        self.priceLabel.text = itemInfo.price;
        
        NSAttributedString *oPriceWithLine =
        [[NSAttributedString alloc]initWithString:itemInfo.oPrice ? itemInfo.oPrice : @""                                       attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSBaselineOffsetAttributeName: @(0)}];
        
        self.oPriceLabel.attributedText = oPriceWithLine;
       
        
        if ([itemInfo.servicePrice isNotEmptyString]) {
            self.servivePrice.text = [NSString stringWithFormat:@"服务费：%@",itemInfo.servicePrice];
        }
        
        
        if (![itemInfo.discountAmount isNotEmptyString]) {
            self.discountLabel.hidden = YES;
            self.discountLabel.width = 0;
        } else {
            self.discountLabel.hidden = NO;
            self.discountLabel.text = itemInfo.discountAmount;
        }
        
        self.shareButton.hidden = !self.showShare;
        self.shareLabel.hidden = self.shareButton.hidden;
        
        self.salesLabel.text = [NSString stringWithFormat:@"%@", itemInfo.sales];
        
        self.discountInfoLabel.text = itemInfo.discountInfo;
        
        self.addressLabel.text = itemInfo.city;
    }
}


+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    
    if (cellData) {
        height = 126;
        ItemInfoModel *itemInfo = (ItemInfoModel *)cellData;
        //itemInfo.title = @"世纪街时间冻结附近附近方法开发开放开发开放开发开放开发开放开发急急急扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩";
        //UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        
        CGSize titleTextSize = [itemInfo.title sizeWithUIFont:ZLNormalFont(14) forWidth:SCREENWIDTH - 12 - 54];
        if (titleTextSize.height > ZLNormalFont(14).lineHeight * 2) {
            height += ceil(ZLNormalFont(14).lineHeight) * 2;
        }else{
            height += ceil(titleTextSize.height);
        }
    }
    return @(height);
}

#pragma mark - properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREENWIDTH - 24, 0)];
        _titleLabel.textColor = ZLGray(62);
        _titleLabel.font = ZLNormalFont(16);
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, 0)];
        _descLabel.textColor = ZLGray(153);
        _descLabel.font = ZLNormalFont(14);
        _descLabel.numberOfLines = 0;
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _descLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
        _priceLabel.textColor = ZLRedColor;
        _priceLabel.font = ZLBoldFont(22);
    }
    return _priceLabel;
}

- (UILabel *)oPriceLabel {
    if (!_oPriceLabel) {
        _oPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _oPriceLabel.textColor = ZLGray(182);
        _oPriceLabel.font = ZLNormalFont(12);
    }
    return _oPriceLabel;
}

- (UILabel *)servivePrice {
    if (!_servivePrice) {
        _servivePrice = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
        _servivePrice.textColor = ZLGray(140);
        _servivePrice.font =ZLNormalFont(14);
    }
    return _servivePrice;
}

- (UILabel *)discountLabel {
    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 27, 14)];
        _discountLabel.textColor = ZLWhiteColor;
        _discountLabel.font = ZLNormalFont(10);
        _discountLabel.numberOfLines = 1;
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        _discountLabel.backgroundColor = ZLRedColor;
        _discountLabel.layer.masksToBounds = YES;
        _discountLabel.layer.cornerRadius = 2;
    }
    
    return _discountLabel;
}

- (UILabel*)shareLabel {
    if (!_shareLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = ZLNormalFont(12);
        label.textColor = ZLGray(170);
        label.text = @"分享";
        [label sizeToFit];
        label.userInteractionEnabled = NO;
        _shareLabel = label;
    }
    return _shareLabel;
}

- (UIButton*)shareButton {
    if (!_shareButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [button setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
        _shareButton = button;
    }
    return _shareButton;
}

- (UIView*)line {
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREENWIDTH-12, LINEWIDTH)];
        view.backgroundColor = ZLGray(233);
        _line = view;
    }
    return _line;
}

- (UILabel *)discountInfoLabel {
    if (!_discountInfoLabel) {
        _discountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _discountInfoLabel.textColor = ZLGray(140);
        _discountInfoLabel.font = ZLNormalFont(14);
    }
    return _discountInfoLabel;
}

- (UILabel *)salesLabel {
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
        _salesLabel.textColor = ZLGray(140);
        _salesLabel.font = ZLNormalFont(14);
    }
    return _salesLabel;
}

- (UILabel*)addressLabel {
    if (!_addressLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = ZLGray(140);
        label.font = ZLNormalFont(14);
        _addressLabel = label;
    }
    return _addressLabel;
}

#pragma mark - action
-(void)handleShareButton {
    if ([self.delegate respondsToSelector:@selector(cell:shareButtonTapped:)]) {
        [self.delegate cell:self shareButtonTapped:self.cellData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    _titleLabel.width = self.width - 20 ;
    _titleLabel.top = 14;
    _titleLabel.left = 10;
    
    [_priceLabel sizeToFit];
    _priceLabel.top = _titleLabel.bottom + 15;
    
    [_oPriceLabel sizeToFit];
    _oPriceLabel.top = self.priceLabel.top;

    ItemInfoModel *itemInfo = (ItemInfoModel *)self.cellData;
    if ([itemInfo.servicePrice isNotEmptyString]) {
        [_servivePrice sizeToFit];
        _servivePrice.right = self.width - 10;
        _servivePrice.centerY = _priceLabel.centerY;
    }
    
    if ([itemInfo.discountInfo isNotEmptyString]) {
        [self.discountLabel sizeToFit];
        _discountLabel.width += 10;
        _discountLabel.height += 2;
        _discountLabel.top = _oPriceLabel.bottom;
    }
    
    _oPriceLabel.left = _priceLabel.right + 4;
    _discountLabel.left = _priceLabel.right + 4;
    
    _shareButton.top = _titleLabel.top - 15;
    _shareButton.right = self.width - 4;
    
    _shareLabel.centerX = _shareButton.centerX;
    _shareLabel.top = _shareButton.bottom - 10;
    _line.top = _priceLabel.bottom + 16;
    
    [_salesLabel sizeToFit];
    _salesLabel.top = _line.bottom + 14;
    
    [_discountInfoLabel sizeToFit];
    _discountInfoLabel.top = _line.bottom + 14;
    _discountInfoLabel.left = _salesLabel.right + 6;
    [_addressLabel sizeToFit];
    _addressLabel.top = _line.bottom + 14;
    _addressLabel.right = self.width - 12;
}
@end
