//
//  UITableViewCell+JYCellMargin.h
//  Demo
//
//  Created by weijingyun on 16/10/2.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (JYCellMargin)

// 设置 cell 的边距
@property (nonatomic, assign) UIEdgeInsets edgeInsets;


#pragma mark - 以下方法需要先设置 edgeInsets 才有效
// 颜色一至 该性能更好
- (void)configEdgeInsetsColor:(UIColor *)color;

// 单独配色可为空
- (void)configTopColor:(UIColor *)topColor leftColor:(UIColor *)leftColor bottomColor:(UIColor *)bottomColor rightColor:(UIColor *)rightColor;

// 设置分割线
- (void)configSeparatorColor:(UIColor *)lineColor hidden:(BOOL)hidden;

@end
