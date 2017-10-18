//
//  OptionSelectView.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "OptionSelectView.h"
#import "OptionUDView.h"

#import "TMCateSiftModel.h"
#import "TMCateSiftKeyModel.h"

@interface OptionSelectView()

@property (nonatomic, strong) NSMutableArray *optionViews;

@end

@implementation OptionSelectView

- (instancetype)copyWithZone:(NSZone *)zone {
    OptionSelectView *optionSelectView = [[OptionSelectView alloc] init];
    optionSelectView.initIndex = self.initIndex;
    optionSelectView.arrayModel = self.arrayModel;
    optionSelectView.delegate = self.delegate;
    return optionSelectView;
}

#pragma mark - override
- (void)initComponent {
    self.backgroundColor = ZLWhiteColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(siftCellTapped:)];
    [self addGestureRecognizer:tap];
}

- (void)setArrayModel:(NSArray *)arrayModel {
    _arrayModel = arrayModel;
    for (int i = 0; i < arrayModel.count; i++) {
        OptionUDView *udView = self.optionViews[i];
        TMCateSiftModel *model = arrayModel[i];
        TMCateSiftKeyModel *key = model.key;
        udView.titleLabel.text = key.desc;
        if (model.options.count == 1) {
            udView.isShowUD = NO;
        } else {
            udView.isShowUD = YES;
        }
        
        if (self.initIndex == i) {
            if (!udView.isSelect) {
                udView.isSelect = YES;
            }
        } else {
            udView.isSelect = NO;
        }
        
//        if ([key.desc isEqualToString:@"价格"]) {
//            udView.isShowUD = YES;
//        } else {
//            udView.isShowUD = NO;
//        }
    }
}

#pragma mark - properties
- (NSMutableArray *)optionViews {
    if (_arrayModel && _arrayModel.count != _optionViews.count) {
        for (UIView *view in _optionViews) {
            [view removeFromSuperview];
        }
        _optionViews = nil;
    }
    
    if (!_optionViews) {
        NSMutableArray *modelViews = [NSMutableArray arrayWithCapacity:_arrayModel.count];
        for (int i = 0; i < _arrayModel.count ; i++) {
            OptionUDView *moduleView = [[OptionUDView alloc] init];
            moduleView.isSelect = NO;
            moduleView.isShowUD = NO;
            [modelViews addObject:moduleView];
            [self addSubview:moduleView];
        }
        _optionViews = modelViews;
    }
    return _optionViews;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = _arrayModel.count;
    CGFloat width = self.width / count;
    for (int i = 0; i < count; i++) {
        UIView *view = self.optionViews[i];
        view.size = CGSizeMake(width, self.height);
        view.left = width * i;
    }
}

- (void)siftCellTapped:(UITapGestureRecognizer *)gesture {
    NSInteger count = _optionViews.count;
    CGFloat width = self.width / count;
    
    CGPoint location = [gesture locationInView:self];
    
    CGFloat x = location.x;
    for (int i = 0; i < count; i++) {
        OptionUDView *view = _optionViews[i];
        if (x > width * i && x < width * (i + 1)) {
            view.isSelect = YES;
            TMCateSiftModel *model = _arrayModel[i];
            TMCateSiftKeyModel *key = model.key;
            TMCateSiftOptionModel *option;
            if (model.options.count == 1) {
                option = model.options[0];
            } else {
                if (view.isOrderUp) {
                    option = model.options[1];
                } else {
                    option = model.options[0];
                }
            }
            if ([self.delegate respondsToSelector:@selector(optionChooseIndex:keyName:keyValue:)]) {
                [self.delegate optionChooseIndex:i keyName:key.name keyValue:option.value];
            }
        } else {
            view.isSelect = NO;
        }
    }
}

@end
