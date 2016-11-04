//
//  UITableView+JYTableLayoutCell.h
//  Demo
//
//  Created by weijingyun on 16/10/5.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

// cell 高度计算等辅助计算
@interface UITableView (JYTableLayoutCell)

- (CGFloat)jy_heightForCellClass:(Class)cellClass withIdentifier:(NSString *)identifier cacheContent:(NSObject *)model key:(NSString *)cachekey configuration:(void (^)(id cell))configuration;

// 计算tableView总高度
- (CGFloat)totalHeight;

@end
