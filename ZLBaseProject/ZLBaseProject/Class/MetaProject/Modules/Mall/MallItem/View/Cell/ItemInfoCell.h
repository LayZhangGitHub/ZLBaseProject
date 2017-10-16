//
//  ItemInfoCell.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseTableCell.h"

@protocol ItemInfoCellDelegate;

@interface ItemInfoCell : BaseTableCell

@property (nonatomic, assign) BOOL showShare;
@property (nonatomic, weak) id<ItemInfoCellDelegate> delegate;

@end

@protocol ItemInfoCellDelegate <NSObject>

- (void)cell:(ItemInfoCell *)cell shareButtonTapped:(id)model;

@end
