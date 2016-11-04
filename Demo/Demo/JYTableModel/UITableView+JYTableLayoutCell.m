//
//  UITableView+JYTableLayoutCell.m
//  Demo
//
//  Created by weijingyun on 16/10/5.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "UITableView+JYTableLayoutCell.h"
#import "UITableViewCell+JYCellMargin.h"
#import <objc/runtime.h>
#import "NSObject+JYTable.h"
#import "JYNodeProtocol.h"

@implementation UITableView (JYTableLayoutCell)

- (CGFloat)jy_heightForCellClass:(Class)cellClass withIdentifier:(NSString *)identifier cacheContent:(NSObject *)model key:(NSString *)cachekey configuration:(void (^)(id cell))configuration{
  
  BOOL isCacheHeight = [cellClass jy_cacheHeight];
  CGFloat height = 0;
  if (isCacheHeight) {
    height = [model.jy_CellHeightDic[cachekey] floatValue];
    if (height > 0) {
      return height;
    }
  }
  
  height = [self jy_heightForCellWithIdentifier:identifier configuration:configuration];
  
  if (isCacheHeight) {
    model.jy_CellHeightDic[cachekey] = [NSNumber numberWithFloat:height];
  }
  return height;
}


- (CGFloat)jy_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration {
  if (!identifier) {
    return 0;
  }
  
  UITableViewCell *templateLayoutCell = [self jy_templateCellForReuseIdentifier:identifier];
  
  // Manually calls to ensure consistent behavior with actual cells (that are displayed on screen).
  [templateLayoutCell prepareForReuse];
  
  // Customize and provide content for our template cell.
  if (configuration) {
    configuration(templateLayoutCell);
  }
    
  templateLayoutCell.translatesAutoresizingMaskIntoConstraints = !UIEdgeInsetsEqualToEdgeInsets(templateLayoutCell.edgeInsets, UIEdgeInsetsZero) ;
  templateLayoutCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
  
  CGFloat contentViewWidth = CGRectGetWidth(self.frame);
  
  // If a cell has accessory view or system accessory type, its content view's width is smaller
  // than cell's by some fixed values.
  if (templateLayoutCell.accessoryView) {
    contentViewWidth -= 16 + CGRectGetWidth(templateLayoutCell.accessoryView.frame);
  } else {
    static const CGFloat systemAccessoryWidths[] = {
      [UITableViewCellAccessoryNone] = 0,
      [UITableViewCellAccessoryDisclosureIndicator] = 34,
      [UITableViewCellAccessoryDetailDisclosureButton] = 68,
      [UITableViewCellAccessoryCheckmark] = 40,
      [UITableViewCellAccessoryDetailButton] = 48
    };
    contentViewWidth -= systemAccessoryWidths[templateLayoutCell.accessoryType];
  }
  
  contentViewWidth -= (templateLayoutCell.edgeInsets.left + templateLayoutCell.edgeInsets.right);
  CGSize fittingSize = CGSizeZero;
  
  if (contentViewWidth > 0) {
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:templateLayoutCell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    widthFenceConstraint.priority = UILayoutPriorityDefaultHigh;
    [templateLayoutCell.contentView addConstraint:widthFenceConstraint];
    // Auto layout engine does its math
    fittingSize = [templateLayoutCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [templateLayoutCell.contentView removeConstraint:widthFenceConstraint];
  }
  
  // Add 1px extra space for separator line if needed, simulating default UITableViewCell.
  if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
    fittingSize.height += 1.0 / [UIScreen mainScreen].scale;
  }

  
  return fittingSize.height;
}


- (UITableViewCell *)jy_templateCellForReuseIdentifier:(NSString *)identifier {
  
  UITableViewCell *templateLayoutCell = [self dequeueReusableCellWithIdentifier:identifier];
  return templateLayoutCell;
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
