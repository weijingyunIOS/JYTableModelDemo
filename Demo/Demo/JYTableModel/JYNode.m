//
//  JYNode.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYNode.h"
#import "NSObject+JYTable.h"

@interface JYNode()

// CellNode
@property (nonatomic, strong) NSMutableArray<JYCellNode *>*groupCellNode;

@end

@implementation JYNode


#pragma mark - cellNode 配置
- (void)bindContentClass:(Class)aContentClass cellNodes:(NSArray*)aNodes{
    [self bindContentClass:aContentClass];
    [self addCellNodes:aNodes];
}

- (void)addCellClass:(Class)cellClass{
    JYCellNode *cellNode = [[JYCellNode alloc] init];
    cellNode.cellClass = cellClass;
    [self.groupCellNode addObject:cellNode];
}

- (void)addCellNode:(JYCellNode *)cellNode{
    [self.groupCellNode addObject:cellNode];
}

- (void)addCellNodes:(NSArray*)aNodes{
    [aNodes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[JYCellNode class]]) {
            [self addCellNode:obj];
        }else{
            [self addCellClass:obj];
        }
    }];
}

#pragma mark - 重写的方法
// 对多cellNode间距的简单配置
- (void)configCellEdgeInsets:(UIEdgeInsets)edgeInsets marginColor:(UIColor *)marginColor{
    if (self.groupCellNode.count == 1) {
        self.groupCellNode.firstObject.edgeInsets = edgeInsets;
        self.groupCellNode.firstObject.marginColor = marginColor;
        return;
    }
    UIEdgeInsets top = UIEdgeInsetsMake(edgeInsets.top, edgeInsets.left, 0, edgeInsets.right);
    UIEdgeInsets bottom = UIEdgeInsetsMake(0, edgeInsets.left, edgeInsets.bottom, edgeInsets.right);
    UIEdgeInsets middle = UIEdgeInsetsMake(0, edgeInsets.left, 0, edgeInsets.right);
    [self.groupCellNode enumerateObjectsUsingBlock:^(JYCellNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.edgeInsets = middle;
        obj.marginColor = marginColor;
    }];
    self.groupCellNode.firstObject.edgeInsets = top;
    self.groupCellNode.lastObject.edgeInsets = bottom;
}

// 分割线颜色配置
- (void)configSeparatorColor:(UIColor *)lineColor {
    self.groupCellNode.lastObject.lineColor = lineColor;
}

// 获取当前要展现的 CellNode
- (JYCellNode *)getCurrentCellNode {
    return self.groupCellNode[self.currentIndex];
}

#pragma mark - 懒加载
- (NSMutableArray<JYCellNode *> *)groupCellNode{
    if (!_groupCellNode) {
        _groupCellNode = [[NSMutableArray alloc] init];
    }
    return _groupCellNode;
}

@end
