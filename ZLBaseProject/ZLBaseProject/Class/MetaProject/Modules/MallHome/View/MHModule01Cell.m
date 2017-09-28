//
//  MHModule01Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule01Cell.h"
#import "ZLSliderView.h"
#import "MHModuleModel.h"

@interface MHModule01Cell () <ZLSliderViewDataSource, ZLSliderViewDelegate>

@property (nonatomic, strong) ZLSliderView *sliderView;
@property (nonatomic, assign) CGFloat height;

@end

@implementation MHModule01Cell

#pragma mark - properties
- (ZLSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[ZLSliderView alloc] initWithStyle:SliderViewPageControlStylePoint
                                                alignment:SliderViewPageControlAlignmentLeft];
        _sliderView.delegate = self;
        _sliderView.dataSource = self;
        _sliderView.autoScroll = NO;
        _sliderView.wrapEnabled = NO;
        _sliderView.currentPageColor = ZLGray(233);
    }
    return _sliderView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _sliderView.frame = CGRectMake(0, 0, self.width, _height);
}

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        _height = [MHModule01Cell heightForCell:self.cellData];
    }
    
    if (self.cellData) {
        [self cellAddSubview:self.sliderView];
        [self.sliderView reloadData];
    }else{
        [_sliderView removeFromSuperview];
        _sliderView = nil;
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    if (cellData) {
        MHModuleModel *ad = (MHModuleModel *)cellData;
        MHItemModel *item = [ad.items objectAtIndex:0];
        if (item) {
            return SCREENWIDTH / item.ar;
        }
    }
    return 0;
}


#pragma mark - TTSliderViewDataSource
- (NSInteger)numberOfItemsInSliderView:(ZLSliderView *)sliderView {
    MHModuleModel *ad = (MHModuleModel *)self.cellData;
    return ad.items.count;
}

- (UIView *)sliderView:(ZLSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (!view) {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        view.userInteractionEnabled = YES;
    }
    
    UIImageView *coverImageView = (UIImageView *) view;
    
    MHModuleModel *ad = (MHModuleModel *)self.cellData;
    MHItemModel *subItem = [ad.items objectAtIndex:index];
    [coverImageView setOnlineImage:subItem.image placeHolderImage:[UIImage imageNamed:@"placeholder_w"]];
    return coverImageView;
}

#pragma mark - TTSliderViewDelegate

- (void)sliderView:(ZLSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index {
    MHModuleModel *ad = (MHModuleModel *)self.cellData;
    
    MHItemModel *adItemModel = [ad.items objectAtIndex:index];
    
    [[ZLNavigationService sharedService] openUrl:adItemModel.link];
}

@end
