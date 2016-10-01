//
//  JYCellNode.m
//  Demo
//
//  Created by weijingyun on 16/10/2.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYCellNode.h"
@implementation JYCellNode

+ (instancetype)cellClass:(Class)aCellClass config:(void (^)(JYCellNode *cellNode))aConfig{
    JYCellNode *node = [[JYCellNode alloc] init];
    node.cellClass = aCellClass;
    if (aConfig) {
        aConfig(node);
    }
    return node;
}

- (instancetype)copyNode{
    JYCellNode *node = [[JYCellNode alloc] init];
    node.cellClass = [self.cellClass copy];
    node.edgeInsets = self.edgeInsets;
    node.topColor = [self.topColor copy];
    node.bottomColor = [self.bottomColor copy];
    node.leftColor = [self.leftColor copy];
    node.rightColor = [self.rightColor copy];
    return node;
}

@end
