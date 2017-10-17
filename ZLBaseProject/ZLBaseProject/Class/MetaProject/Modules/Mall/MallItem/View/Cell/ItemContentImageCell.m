//
//  ItemContentImageCell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ItemContentImageCell.h"

#import "ItemDetailContentModel.h"

@interface ItemContentImageCell()

@property (nonatomic, strong) UIImageView *itemImageView;

@end

@implementation ItemContentImageCell

- (void)initCellComponent {
    self.backgroundColor = ZLGray(245);
    
    [self addSubview:self.itemImageView];
}

- (void)reloadData{
    if (self.cellData) {
        ItemDetailContentModel *imageUnit = (ItemDetailContentModel *)self.cellData;
        
        [self.itemImageView setOnlineImage:imageUnit.image placeHolderImage:[UIImage imageNamed:@"placeholder_s"]];
        self.itemImageView.height = (SCREENWIDTH - 20) / imageUnit.ar;
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    CGFloat height = 0;
    if (cellData) {
        ItemDetailContentModel *imageUnit = (ItemDetailContentModel *)cellData;
        height = (SCREENWIDTH - 20) / imageUnit.ar;
    }
    return @(height);
}

#pragma mark - properties
- (UIImageView *)itemImageView {
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, 0)];
    }
    return _itemImageView;
}

@end
