//
//  TMOptionSelectCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TMOptionSelectCell.h"


@interface TMOptionSelectCell()



@end

@implementation TMOptionSelectCell

#pragma mark - override
- (void)reloadData {
    if (self.cellData) {
        [self addSubview:self.optionSelectView];
        self.optionSelectView.arrayModel = self.cellData;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        height = 45 + 10;
    }
    return @(height);
}

#pragma mark - properties
- (OptionSelectView *)optionSelectView {
    if (!_optionSelectView) {
        _optionSelectView = [[OptionSelectView alloc] init];
    }
    return _optionSelectView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _optionSelectView.size = CGSizeMake(self.width, self.height - 10);
}


@end
