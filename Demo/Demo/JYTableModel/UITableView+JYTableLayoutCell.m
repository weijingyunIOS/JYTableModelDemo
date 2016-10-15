//
//  UITableView+JYTableLayoutCell.m
//  Demo
//
//  Created by weijingyun on 16/10/5.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "UITableView+JYTableLayoutCell.h"
#import "NSObject+JYTable.h"
#import <UITableView+FDTemplateLayoutCell.h>

@implementation UITableView (JYTableLayoutCell)

- (CGFloat)jy_heightForCellWithIdentifier:(NSString *)identifier cacheContent:(NSObject *)content key:(NSString *)key configuration:(void (^)(id cell))configuration{
  
  CGFloat height = [content.jy_CellHeightDic[key] floatValue];
    if (height > 0) {
        return height;
    }
    height = [self fd_heightForCellWithIdentifier:identifier configuration:configuration];
  content.jy_CellHeightDic[key] = [NSNumber numberWithFloat:height];
  return height;
}


// 计算tableView总高度
- (CGFloat)totalHeight{
    
    CGFloat height = 0.f;
    UITableView *tableView = self;
    height += self.tableHeaderView.frame.size.height;
    
    NSInteger section = [tableView.dataSource numberOfSectionsInTableView:tableView];
    for (int i = 0; i < section; i ++) {
        
        // 组头高度
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            height += [tableView.delegate tableView:tableView heightForHeaderInSection:i];
        }
        
        // cell 高度
        NSInteger row = [tableView.dataSource tableView:tableView numberOfRowsInSection:i];
        for (int j= 0 ; j < row; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            if ([tableView.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
                height += [tableView.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
            }
        }
        
        // 组尾高度
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
            height += [tableView.delegate tableView:tableView heightForFooterInSection:i];
        }
        
    }
    
    height += self.tableFooterView.frame.size.height;
    return height;
}

@end
