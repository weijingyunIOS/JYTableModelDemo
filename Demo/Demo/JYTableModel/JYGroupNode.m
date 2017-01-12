//
//  JYGroupNode.m
//  Demo
//
//  Created by weijingyun on 2017/1/12.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "JYGroupNode.h"
#import "JYNodeProtocol.h"

@interface JYGroupNode ()


@end

@implementation JYGroupNode

// 对cellNode间距的简单配置
- (void)configCellEdgeInsets:(UIEdgeInsets)edgeInsets marginColor:(UIColor *)marginColor {
 
    UIEdgeInsets top = UIEdgeInsetsMake(edgeInsets.top, edgeInsets.left, 0, edgeInsets.right);
    UIEdgeInsets bottom = UIEdgeInsetsMake(0, edgeInsets.left, edgeInsets.bottom, edgeInsets.right);
    UIEdgeInsets middle = UIEdgeInsetsMake(0, edgeInsets.left, 0, edgeInsets.right);
    self.groupHeaderCellNode.edgeInsets = top;
    self.groupCellNode.edgeInsets = middle;
    self.groupFooterCellNode.edgeInsets = bottom;
}

// 分割线颜色配置
- (void)configSeparatorColor:(UIColor *)lineColor {
    self.groupFooterCellNode.lineColor = lineColor;
}

// 当前的
- (JYCellNode *)getCurrentCellNode {
    JYCellNode *cellNode = nil;
    switch (self.currentIndex) {
        case 0:
            cellNode = self.groupHeaderCellNode;
            break;
        case 1:
            cellNode = self.groupCellNode;
            break;
        case 2:
            cellNode = self.groupFooterCellNode;
            break;
            
        default:
            break;
    }
    return cellNode;
}

- (id)conversionModel {
    return self.content;
}


@end
