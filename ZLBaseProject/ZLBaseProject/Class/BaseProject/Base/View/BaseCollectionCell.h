//
//  BaseCollectionCell.h
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionCell : UICollectionViewCell

@property (nonatomic, strong) id cellData;

+ (NSString *)cellIdentifier;
+ (CGFloat)heightForCell:(id)cellData;
+ (instancetype)dequeueReusableCellForCollectionView:(UICollectionView *)collectionView
                                        forIndexPath:(NSIndexPath *)indexPath;

@end
