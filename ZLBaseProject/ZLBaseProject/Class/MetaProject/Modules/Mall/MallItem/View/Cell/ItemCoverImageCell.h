//
//  ItemCoverImageCell.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseTableCell.h"

@protocol ItemCoverImageCellDelegate;

@interface ItemCoverImageCell : BaseTableCell

@property (nonatomic, weak) id<ItemCoverImageCellDelegate> delegate;

- (void)scrollToCoverImageAtIndex:(NSInteger)index;

@end

@protocol ItemCoverImageCellDelegate <NSObject>

- (void)didTapCoverImageAtIndex:(NSInteger)index;

@end

