//
//  ItemCommentContentCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemCommentContentCell.h"

#import "ItemCommentModel.h"

@interface ItemCommentContentCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *skuLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageViews;

@end

@implementation ItemCommentContentCell

- (void)initCellComponent {
    self.backgroundColor = ZLWhiteColor;
    
    [self cellAddSubview:self.lineView];
    [self cellAddSubview:self.avatarImageView];
    [self cellAddSubview:self.nameLabel];
    [self cellAddSubview:self.contentLabel];
    [self cellAddSubview:self.timeLabel];
    [self cellAddSubview:self.skuLabel];
    for (UIImageView *imageView  in self.imageViews) {
        [self cellAddSubview:imageView];
    }
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ItemCommentModel *commentModel = (ItemCommentModel *)self.cellData;
        //commentFeed.content = @"是多少积分打发时间附加费是开发商开发商开发开放开发开发商开发开放开放开发开放开发开放开发反馈方法方法付付付付付付付付付付付付付付付付付付付付付付付付付付付";
        
        [self.avatarImageView setOnlineImage:commentModel.avatar placeHolderImage:[UIImage imageNamed:@"mine_default_avatar"]];
        
        self.nameLabel.text = commentModel.name;
        [self.nameLabel sizeToFit];
        self.nameLabel.left = self.avatarImageView.right + 10;
        self.nameLabel.centerY = self.avatarImageView.centerY;
        
        self.contentLabel.text = commentModel.content;
        self.contentLabel.width = SCREENWIDTH - 14 * 2;
        [self.contentLabel sizeToFit];
        
        self.timeLabel.text = commentModel.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.top = self.contentLabel.bottom + 5;
        self.timeLabel.left = 14;
        
        self.skuLabel.text = commentModel.skuDesc;
        [self.skuLabel sizeToFit];
        self.skuLabel.top = self.timeLabel.top;
        self.skuLabel.left = self.timeLabel.right + 5;
        
        NSArray<NSString *> *images = commentModel.images;
        int i = 0;
        for (; i < images.count; i++) {
            
            UIImageView *imageView = self.imageViews[i];
            imageView.hidden = NO;
            imageView.top = i / 3 * ( imageView.width + 2 ) + self.timeLabel.bottom + 5;
            NSString *imageSrc = images[i];
            [imageView setOnlineImage:imageSrc];
            
        }
        
        for (; i < 6; i++) {
            UIImageView *imageView = self.imageViews[i];
            imageView.image = nil;
            imageView.hidden = YES;
        }
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    CGFloat cellHeight = 0;
    if (cellData) {
        ItemCommentModel *commentModel = (ItemCommentModel *)cellData;
        
        NSString *text = commentModel.content;
        
        CGFloat textHeight = 0;
        if ([text isNotEmptyString]) {
            textHeight = [text sizeWithUIFont:ZLNormalFont(14) forWidth:SCREENWIDTH - 14 * 2].height;
        }
        
        cellHeight = 92 + ceil(textHeight) + 16;//5是底部margin，74是除了图片以及图片上方margin
        
        NSArray<NSString *> *images = commentModel.images;
        if ( images.count > 0 ) {
            CGFloat imageHeight = (SCREENWIDTH - 60 -24 -2*2)/3;
            cellHeight += 5 + imageHeight + ( images.count - 1 ) / 3 * (imageHeight + 2 );
        }
        
    }
    
    return cellHeight;
}

#pragma mark - Getters And Setters

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREENWIDTH - 15 - 12, LINEWIDTH)];
        _lineView.backgroundColor = ZLGray(230);
    }
    
    return _lineView;
}

- (UIImageView *)avatarImageView {
    
    if ( !_avatarImageView ) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 12, 20, 46, 46)];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 23;
    }
    
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    
    if ( !_nameLabel ) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _nameLabel.textColor = ZLGray(45);
        _nameLabel.font = ZLNormalFont(16);
    }
    
    return _nameLabel;
}

- (UILabel *)contentLabel {
    
    if ( !_contentLabel ) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 72, SCREENWIDTH - 14 * 2, 0)];
        _contentLabel.textColor = ZLGray(90);
        _contentLabel.font = ZLNormalFont(14);
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}

- (UILabel *)timeLabel {
    
    if ( !_timeLabel ) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _timeLabel.textColor = ZLGray(174);
        _timeLabel.font = ZLNormalFont(14);
    }
    
    return _timeLabel;
}

- (UILabel *)skuLabel {
    
    if ( !_skuLabel ) {
        _skuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _skuLabel.textColor = ZLGray(174);
        _skuLabel.font = ZLNormalFont(14);
    }
    
    return _skuLabel;
}

- (NSArray<UIImageView *> *)imageViews {
    
    if ( !_imageViews ) {
        
        _imageViews = [[NSMutableArray<UIImageView *> alloc] initWithCapacity:6];
        
        CGFloat imageWidth = (SCREENWIDTH - 60 -24 -2*2)/3;
        
        for ( int i = 0; i < 6; i++) {
            
            CGFloat imageX = i % 3 * ( imageWidth + 2 ) + 12;
            CGFloat imageY = i / 3 * ( imageWidth + 2 );
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageWidth)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
            [imageView addGestureRecognizer:tapGesturRecognizer];
            
            [_imageViews addObject:imageView];
            
        }
        
    }
    
    return _imageViews;
}

#pragma mark - Event Response

- (void) tapImage:(UITapGestureRecognizer *) tapGestureRecognizer {
    
//    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
//
//    TTGalleryViewController *vc = [[TTGalleryViewController alloc] init];
//
//    ITCommentFeedModel *commentFeed = (ITCommentFeedModel *)self.cellData;
//
//    NSArray *images = commentFeed.images;
//
//    vc.images = images;
//    vc.index = tapGestureRecognizer.view.tag;
//
//    [navigationController pushViewController:vc animated:YES];
    
}


@end
