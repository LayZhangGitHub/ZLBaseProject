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

#define EDGE 10
#define RIGHTICONVIEW_WIDTH ((SCREENWIDTH - 3 * EDGE) * 0.4275)

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
        _iconHeight = RIGHTICONVIEW_WIDTH / item.ar;
        } else {
            _iconHeight = RIGHTICONVIEW_WIDTH / 0.77;
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
            height = RIGHTICONVIEW_WIDTH / item.ar + 2 * EDGE;
        }else{
            height = RIGHTICONVIEW_WIDTH / 0.77 + 2 * EDGE;
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
    
    CGFloat leftWidth = SCREENWIDTH - RIGHTICONVIEW_WIDTH - 3 * EDGE;
    CGFloat leftHeight = (_iconHeight - EDGE) / 2;
    Instrument02View *moduleViewIndex0 = [self.moduleViews objectAtIndex:0];
    moduleViewIndex0.frame = CGRectMake(EDGE, EDGE, leftWidth, leftHeight);
    
    Instrument02View *moduleViewIndex1 = [self.moduleViews objectAtIndex:1];
    moduleViewIndex1.frame = CGRectMake(EDGE, moduleViewIndex0.bottom + EDGE, leftWidth, leftHeight);
    
    Instrument02View *moduleViewIndex2 = [self.moduleViews objectAtIndex:2];
    moduleViewIndex2.frame = CGRectMake(moduleViewIndex0.right + EDGE, EDGE, RIGHTICONVIEW_WIDTH, _iconHeight);
}

@end
