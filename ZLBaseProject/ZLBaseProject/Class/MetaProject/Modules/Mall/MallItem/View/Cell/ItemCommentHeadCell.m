//
//  ItemCommentHeadCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemCommentHeadCell.h"

#import "ItemCommentsInfoModel.h"

@interface ItemCommentHeadCell()

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation ItemCommentHeadCell

#pragma mark - override
- (void)initCellComponent {
    self.backgroundColor = ZLWhiteColor;
    
    [self addSubview:self.countLabel];
    [self addSubview:self.moreImageView];
}

- (void)reloadData{
    if (self.cellData) {
        ItemCommentsInfoModel *commentsModel = (ItemCommentsInfoModel *)self.cellData;
        
        self.countLabel.text = [NSString stringWithFormat:@"买家留言（%@）", commentsModel.cmtCount];
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        height = 44;
    }
    return @(height);
}

#pragma mark - properties
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _countLabel.textColor = ZLGray(170);
        _countLabel.font = ZLNormalFont(14);
    }
    return _countLabel;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
    }
    return _moreImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_countLabel sizeToFit];
    _countLabel.top = 13;
    _countLabel.left = 12;
    
    _moreImageView.centerY = self.height / 2;
    _moreImageView.right = self.width - 13;
}


@end
