
//
//  ItemShopInfoCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemShopInfoCell.h"

@interface ItemShopInfoCell()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *shopNameLabel;
//@property (nonatomic, strong) ITMarkView *markView;

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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
