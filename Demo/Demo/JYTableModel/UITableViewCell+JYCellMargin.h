//
//  UITableViewCell+JYCellMargin.h
//  Demo
//
//  Created by weijingyun on 16/10/2.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSwizzlingDefine.h"

@interface UITableViewCell (JYCellMargin)

// 设置 cell 的边距
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end
