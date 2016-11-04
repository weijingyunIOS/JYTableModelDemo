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

// 当前cell所在的indexPath
@property (nonatomic, strong) NSIndexPath *jy_indexPath;


#pragma mark - 以下方法需要先设置 edgeInsets 才有效
// 颜色一至 该性能更好
- (void)configEdgeInsetsColor:(UIColor *)color;

// 单独配色可为空
- (void)configTopColor:(UIColor *)topColor leftColor:(UIColor *)leftColor bottomColor:(UIColor *)bottomColor rightColor:(UIColor *)rightColor;

// 设置分割线
- (void)configSeparatorColor:(UIColor *)lineColor hidden:(BOOL)hidden;

// 是否为cell缓存高度  默认缓存，可重写该方法 return NO， 则不会缓存高度
+ (BOOL)jy_cacheHeight;

// 根据model获取cellType
+ (NSInteger)cellTypeForContent:(id)content;

@end
