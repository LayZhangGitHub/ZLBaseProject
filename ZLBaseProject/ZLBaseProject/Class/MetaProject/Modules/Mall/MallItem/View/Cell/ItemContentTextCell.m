//
//  ItemContentTextCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemContentTextCell.h"

#import "ItemDetailContentModel.h"

@interface ItemContentTextCell()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ItemContentTextCell

- (void)initCellComponent {
    self.backgroundColor = ZLGray(245);
    [self addSubview:self.contentLabel];
}

- (void)reloadData{
    if (self.cellData) {
        NSString *content = (NSString *)self.cellData;
        self.contentLabel.text = content;
        [self.contentLabel sizeToFit];
        self.contentLabel.width = SCREENWIDTH - 10 * 2;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat heith = 0;
    if (cellData) {
        ItemDetailContentModel *contentModel = (ItemDetailContentModel *)cellData;
        NSString *text = contentModel.text;
        CGSize textSize = [text sizeWithUIFont:ZLNormalFont(14)
                                      forWidth:SCREENWIDTH - 10 * 2];
        heith = ceil(textSize.height) + 15;
    }
    return @(heith);
}

#pragma mark - properties
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREENWIDTH - 10 * 2, 0)];
        _contentLabel.textColor = ZLGray(148);
        _contentLabel.font = ZLNormalFont(14);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
@end
