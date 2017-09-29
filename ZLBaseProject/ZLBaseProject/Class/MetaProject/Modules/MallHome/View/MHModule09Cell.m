//
//  MHModule09Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/29.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule09Cell.h"
#import "MHModuleModel.h"
#import "Instrument02View.h"

#define Edge 10
#define RightIconViewWidth ((SCREENWIDTH - 3 * Edge) * 0.4275)

@interface MHModule09Cell()
@property (nonatomic, strong) NSArray *moduleViews;
@property (nonatomic, assign) CGFloat iconHeight;
@end

@implementation MHModule09Cell

#pragma mark - override

- (void)reloadData {
    if (self.cellData) {
        self.backgroundColor = ZLWhiteColor;
        
        MHModuleModel *model = self.cellData;
        
        MHItemModel *item = [model.items objectAtIndex:2];
        
        if (item) {
        _iconHeight = RightIconViewWidth / item.ar;
        } else {
            _iconHeight = RightIconViewWidth / 0.77;
        }
        
        
        for (int i = 0; i < 3; i++) {
            MHItemModel *item = [model.items objectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";
            
            Instrument02View *module = [self.moduleViews objectAtIndex:i];
            [module setModel:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_s"}];
            
        }
    }
}

+ (NSNumber *)heightForCell:(id)cellData {
    
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        
        MHItemModel *item = [model.items objectAtIndex:2];
        if (item) {
            height = RightIconViewWidth / item.ar + 2 * Edge;
        }else{
            height = RightIconViewWidth / 0.77 + 2 * Edge;
        }
        
    }
    return @(height);
}

#pragma mark - properties
- (NSArray *)moduleViews {
    if (!_moduleViews) {
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:3];
        for (int i = 0; i<3; i++) {
            Instrument02View *moduleView = [[Instrument02View alloc] init];
            [modules addObject:moduleView];
            [self cellAddSubview:moduleView];
        }
        _moduleViews = [NSArray arrayWithArray:modules];
    }
    return _moduleViews;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat leftWidth = SCREENWIDTH - RightIconViewWidth - 3 * Edge;
    CGFloat leftHeight = (_iconHeight - Edge) / 2;
    Instrument02View *moduleViewIndex0 = [self.moduleViews objectAtIndex:0];
    moduleViewIndex0.frame = CGRectMake(Edge, Edge, leftWidth, leftHeight);
    
    Instrument02View *moduleViewIndex1 = [self.moduleViews objectAtIndex:1];
    moduleViewIndex1.frame = CGRectMake(Edge, moduleViewIndex0.bottom + Edge, leftWidth, leftHeight);
    
    Instrument02View *moduleViewIndex2 = [self.moduleViews objectAtIndex:2];
    moduleViewIndex2.frame = CGRectMake(moduleViewIndex0.right + Edge, Edge, RightIconViewWidth, _iconHeight);
}

@end
