
//
//  ItemShopInfoCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemShopInfoCell.h"

#import "ItemShopInfoModel.h"

#import "ItemMarkView.h"

@interface ItemShopInfoCell()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) ItemMarkView *markView;

@property (nonatomic, strong) UILabel *salesLabel;
@property (nonatomic, strong) UILabel *salesValueLabel;
@property (nonatomic, strong) UIView *pipe1;

@property (nonatomic, strong) UILabel *favCountLabel;
@property (nonatomic, strong) UILabel *favCountValueLabel;
@property (nonatomic, strong) UIView *pipe2;

@property (nonatomic, strong) UILabel *msTextLabel;
@property (nonatomic, strong) UILabel *msValueLabel;
@property (nonatomic, strong) UILabel *msTagLabel;

@property (nonatomic, strong) UILabel *zlTextLabel;
@property (nonatomic, strong) UILabel *zlValueLabel;
@property (nonatomic, strong) UILabel *zlTagLabel;

@property (nonatomic, strong) UILabel *jgTextLabel;
@property (nonatomic, strong) UILabel *jgValueLabel;
@property (nonatomic, strong) UILabel *jgTagLabel;

@property (nonatomic, strong) UIButton *shopButton;

@end

@implementation ItemShopInfoCell

#pragma mark - override

- (void)initCellComponent {
    
    self.backgroundColor = ZLWhiteColor;
    
    [self addSubview:self.logoImageView];
    [self addSubview:self.shopNameLabel];
    [self addSubview:self.markView];
    [self addSubview:self.salesLabel];
    [self addSubview:self.salesValueLabel];
    [self addSubview:self.favCountLabel];
    [self addSubview:self.favCountValueLabel];
    [self addSubview:self.pipe1];
    [self addSubview:self.pipe2];
    
    [self addSubview:self.msTextLabel];
    [self addSubview:self.msValueLabel];
    //[self addSubview:self.msTagLabel];
    
    [self addSubview:self.zlTextLabel];
    [self addSubview:self.zlValueLabel];
    //[self addSubview:self.zlTagLabel];
    
    [self addSubview:self.jgTextLabel];
    [self addSubview:self.jgValueLabel];
    //[self addSubview:self.jgTagLabel];
    
    [self addSubview:self.shopButton];
    
    weakSelf(self);
    [self bk_whenTapped:^{
        strongSelf(self);
        [self handleAllButton];
    }];
}


- (void)reloadData{
    if (self.cellData) {
        
        ItemShopInfoModel *shopInfo = (ItemShopInfoModel *)self.cellData;
        
        [self.logoImageView setOnlineImage:shopInfo.logo];
        
        self.shopNameLabel.text = shopInfo.shopName;
        [self.shopNameLabel sizeToFit];
        self.shopNameLabel.left = 72;
        
        self.markView.mark = [shopInfo.dsr.qb.v floatValue];
        
        self.salesValueLabel.text = shopInfo.sales;
        [self.salesValueLabel sizeToFit];
        self.salesValueLabel.centerX = SCREENWIDTH / 6;
        self.salesValueLabel.top = 92;
        
        self.salesLabel.text = @"总销量";
        [self.salesLabel sizeToFit];
        self.salesLabel.centerX = SCREENWIDTH / 6;
        self.salesLabel.top = self.salesValueLabel.bottom + 5;
        
        self.favCountValueLabel.text = shopInfo.favCount;
        [self.favCountValueLabel sizeToFit];
        self.favCountValueLabel.centerX = SCREENWIDTH / 2;
        self.favCountValueLabel.top = 92;
        
        self.favCountLabel.text = @"收藏数";
        [self.favCountLabel sizeToFit];
        self.favCountLabel.centerX = SCREENWIDTH / 2;
        self.favCountLabel.top = self.favCountValueLabel.bottom + 5;
        
        self.pipe1.centerX = SCREENWIDTH/3;
        self.pipe2.centerX = SCREENWIDTH*2/3.;
        
        self.msTextLabel.centerX = SCREENWIDTH*5/6. - 20;
        self.msTextLabel.top = 85;
        
        self.msValueLabel.text = shopInfo.dsr.ms.v;
        [self.msValueLabel sizeToFit];
        self.msValueLabel.left = self.msTextLabel.right + 2;
        self.msValueLabel.top = self.msTextLabel.top;
        
        self.jgTextLabel.top = self.msValueLabel.bottom + 5;
        self.jgTextLabel.centerX = SCREENWIDTH*5/6. - 20;
        
        self.jgValueLabel.text = shopInfo.dsr.jg.v;
        [self.jgValueLabel sizeToFit];
        self.jgValueLabel.top = self.jgTextLabel.top;
        self.jgValueLabel.left = self.jgTextLabel.right + 2;
        
        self.zlTextLabel.top = self.jgTextLabel.bottom + 5;
        self.zlTextLabel.centerX = SCREENWIDTH*5/6. - 20;
        
        self.zlValueLabel.text = shopInfo.dsr.zl.v;
        [self.zlValueLabel sizeToFit];
        self.zlValueLabel.top = self.zlTextLabel.top;
        self.zlValueLabel.left = self.zlTextLabel.right + 2;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat cellHeight = 0;
    if (cellData) {
        cellHeight = 223;
    }
    return @(cellHeight);
}

#pragma mark - properties
- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 50, 50)];
    }
    return _logoImageView;
}

- (UILabel *)shopNameLabel {
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 15, 0, 0)];
        _shopNameLabel.textColor = ZLGray(17);
        _shopNameLabel.font = ZLNormalFont(16);
    }
    return _shopNameLabel;
}

- (ItemMarkView *)markView {
    if (!_markView) {
        ItemMarkView *markView = [[ItemMarkView alloc] init];
        markView.left = 76;
        markView.top = 46;
        markView.markWidth = 12;
        markView.showMark = NO;
        markView.userInteractionEnabled = NO;
        [markView sizeToFit];
        _markView = markView;
    }
    return _markView;
}

- (UILabel*)salesValueLabel {
    if (!_salesValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = ZLNormalFont(18);
        label.textColor = ZLGray(62);
        _salesValueLabel = label;
    }
    return _salesValueLabel;
}

- (UILabel *)salesLabel {
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _salesLabel.textColor = ZLGray(174);
        _salesLabel.font = ZLNormalFont(14);
    }
    return _salesLabel;
}

- (UIView*)pipe1 {
    if (!_pipe1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 96, LINEWIDTH, 44)];
        view.backgroundColor = ZLGray(233);
        _pipe1 = view;
    }
    return _pipe1;
}

- (UILabel*)favCountValueLabel {
    if (!_favCountValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = ZLNormalFont(18);
        label.textColor = ZLGray(62);
        _favCountValueLabel = label;
    }
    return _favCountValueLabel;
}

- (UILabel *)favCountLabel {
    if (!_favCountLabel) {
        _favCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _favCountLabel.textColor = ZLGray(169);
        _favCountLabel.font = ZLNormalFont(14);
    }
    
    return _favCountLabel;
}

- (UIView*)pipe2 {
    if (!_pipe2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 96, LINEWIDTH, 44)];
        view.backgroundColor = ZLGray(233);
        _pipe2 = view;
    }
    return _pipe2;
}

- (UILabel *)msTextLabel {
    if (!_msTextLabel) {
        _msTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _msTextLabel.textColor = ZLGray(170);
        _msTextLabel.font = ZLNormalFont(14);
        _msTextLabel.text = @"描述相符";
        [_msTextLabel sizeToFit];
    }
    
    return _msTextLabel;
}

- (UILabel *)msValueLabel {
    if (!_msValueLabel) {
        _msValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _msValueLabel.textColor = ZLRedColor;
        _msValueLabel.font = ZLNormalFont(14);
    }
    
    return _msValueLabel;
}

- (UILabel *)msTagLabel {
    if (!_msTagLabel) {
        _msTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _msTagLabel.textColor = ZLWhiteColor;
        _msTagLabel.font = ZLNormalFont(10);
        _msTagLabel.backgroundColor = ZLRedColor;
        _msTagLabel.layer.masksToBounds = YES;
        _msTagLabel.layer.cornerRadius = 2;
        _msTagLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _msTagLabel;
}

- (UILabel *)zlTextLabel {
    if (!_zlTextLabel) {
        _zlTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _zlTextLabel.textColor = ZLGray(170);
        _zlTextLabel.font = ZLNormalFont(14);
        _zlTextLabel.text = @"质量满意";
        [_zlTextLabel sizeToFit];
    }
    return _zlTextLabel;
}

- (UILabel *)zlValueLabel {
    if (!_zlValueLabel) {
        _zlValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _zlValueLabel.textColor = ZLRedColor;
        _zlValueLabel.font = ZLNormalFont(14);
    }
    return _zlValueLabel;
}

- (UILabel *)zlTagLabel {
    if (!_zlTagLabel) {
        _zlTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _zlTagLabel.textColor = ZLWhiteColor;
        _zlTagLabel.font = ZLNormalFont(10);
        _zlTagLabel.backgroundColor = ZLRedColor;
        _zlTagLabel.layer.masksToBounds = YES;
        _zlTagLabel.layer.cornerRadius = 2;
        _zlTagLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _zlTagLabel;
}

- (UILabel *)jgTextLabel {
    if (!_jgTextLabel) {
        _jgTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _jgTextLabel.textColor = ZLGray(170);
        _jgTextLabel.font = ZLNormalFont(14);
        _jgTextLabel.text = @"价格合理";
        [_jgTextLabel sizeToFit];
    }
    return _jgTextLabel;
}

- (UILabel *)jgValueLabel {
    if (!_jgValueLabel) {
        _jgValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _jgValueLabel.textColor = ZLRedColor;
        _jgValueLabel.font = ZLNormalFont(14);
    }
    return _jgValueLabel;
}

- (UILabel *)jgTagLabel {
    if (!_jgTagLabel) {
        _jgTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _jgTagLabel.textColor = ZLWhiteColor;
        _jgTagLabel.font = ZLNormalFont(10);
        _jgTagLabel.backgroundColor = ZLRedColor;
        _jgTagLabel.layer.masksToBounds = YES;
        _jgTagLabel.layer.cornerRadius = 2;
        _jgTagLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _jgTagLabel;
}

- (UIButton *)shopButton {
    if (!_shopButton) {
        _shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopButton.frame = CGRectMake(0, 0, 0, 0);
        _shopButton.titleLabel.font = ZLNormalFont(14);
        [_shopButton addTarget:self action:@selector(handleAllButton) forControlEvents:UIControlEventTouchUpInside];
        [_shopButton setTitleColor:ZLGray(153) forState:UIControlStateNormal];
        [_shopButton setTitle:@"进店逛逛" forState:UIControlStateNormal];
        [_shopButton sizeToFit];
        _shopButton.layer.borderColor = ZLGray(153).CGColor;
        _shopButton.layer.borderWidth = 1.0f;
        _shopButton.layer.masksToBounds = YES;
        _shopButton.layer.cornerRadius = 2.0f;
        _shopButton.width = 127;
        _shopButton.height = 38;
        _shopButton.centerX = SCREENWIDTH / 2;
        _shopButton.bottom = 208;
    }
    return _shopButton;
}

#pragma mark - handle action
- (void)handleAllButton {
    ItemShopInfoModel *shopInfo = (ItemShopInfoModel *)self.cellData;
    if ([shopInfo.link isNotEmptyString]) {
        [[ZLNavigationService sharedService] openUrl:shopInfo.link];
    }
}
@end
