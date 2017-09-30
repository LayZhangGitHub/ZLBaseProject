//
//  MHModule23Cell.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/9/29.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MHModule23Cell.h"

@interface MHModule23Cell()

@property (nonatomic, strong) NSArray *moduleViews;

@end

@implementation MHModule23Cell


//- (void)reloadData{
//
//    if (self.cellData) {
//
//        self.backgroundColor = Color_White;
//        [self removeAllSubviews];
//
//        MHModuleModel *model = self.cellData;
//
//        for (int i = 0; i<model.items.count; i++) {
//
//            MHomeItemView *moduleView = [[MHomeItemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57)];
//            moduleView.left = 0;
//            moduleView.top = 57 * i;
//
//            [moduleView reloadData:[model.items safeObjectAtIndex:i]];
//            [self cellAddSubview:moduleView];
//
//        }
//
//    }
//}
//
//+ (CGFloat)heightForCell:(id)cellData{
//    CGFloat height = 0;
//    if (cellData) {
//        MHModuleModel *model = cellData;
//
//        height = 57 * model.items.count;
//    }
//    return height;
//}

#pragma mark - properties
//- (NSMutableArray*)moduleViews {
//    if (!_moduleViews) {
//        MHModuleModel *model = self.cellData;
//        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:model.items.count];
//        for (int i = 0; i<model.items.count; i++) {
//
//            MHomeItemView *moduleView = [[MHomeItemView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 57)];
//            moduleView.left = 0;
//            moduleView.top = 57 * i;
//            [modules addObject:moduleView];
//        }
//
//        _moduleViews = modules;
//    }
//    return _moduleViews;
//}

@end
