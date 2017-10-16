//
//  ItemCoverImageCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemCoverImageCell.h"

#import "ItemCoverImageModel.h"

#import "ZLSliderView.h"

@interface ItemCoverImageCell() <ZLSliderViewDelegate, ZLSliderViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) ZLSliderView *sliderView;
@property (nonatomic, assign) NSUInteger pageIndex;

@end

@implementation ItemCoverImageCell
#pragma mark - override
- (void)initCellComponent {
    [self cellAddSubview:self.sliderView];
}

- (void)reloadData {
    if (self.cellData) {
        [self cellAddSubview:self.sliderView];
        [self.sliderView reloadData];
    }else{
        [_sliderView removeFromSuperview];
        _sliderView = nil;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        ItemCoverImageModel *model = (ItemCoverImageModel *)cellData;
        height = (SCREENWIDTH - 80) / model.ar + 8;
    }
    return @(height);
}

#pragma mark - publick
- (void)scrollToCoverImageAtIndex:(NSInteger)index {
    [self.sliderView scrollToItemAtIndex:index];
}

#pragma mark - properties
- (ZLSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[ZLSliderView alloc] initWithStyle:SliderViewPageControlStylePoint
                                                alignment:SliderViewPageControlAlignmentCenter];
        _sliderView.delegate = self;
        _sliderView.dataSource = self;
        _sliderView.autoScroll = YES;
        _sliderView.wrapEnabled = NO;
        _sliderView.currentPageColor = ZLGray(233);
    }
    return _sliderView;
}

#pragma mark - TTSliderViewDataSource
- (NSInteger)numberOfItemsInSliderView:(ZLSliderView *)sliderView {
    ItemCoverImageModel *model = (ItemCoverImageModel *)self.cellData;
    return model.src.count;
}

- (UIView *)sliderView:(ZLSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *coverImageView = nil;
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 4, sliderView.width - 80 * 2, sliderView.height - 8)];
        view.userInteractionEnabled = YES;
        [view addSubview:coverImageView];
    } else {
        coverImageView = [view subviews][0];
    }
    
    ItemCoverImageModel *model = (ItemCoverImageModel *)self.cellData;
    NSString *imageSrc = model.src[index];
    [coverImageView setOnlineImage:imageSrc placeHolderImage:[UIImage imageNamed:@"placeholder_w"]];
    return view;
}

#pragma mark - TTSliderViewDelegate

- (void)sliderView:(ZLSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(didTapCoverImageAtIndex:)]) {
        [self.delegate didTapCoverImageAtIndex:index];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _sliderView.frame = CGRectMake(0, 0, self.width, self.height);
}

@end
