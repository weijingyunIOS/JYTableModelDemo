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

// 外部展现时对应 的 cellClass
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) id content;

// CellNode
@property (nonatomic, strong) NSMutableArray<JYCellNode *>*groupCellNode;
@property (nonatomic, strong) Class contentClass;

@end

@implementation JYNode


- (void)recordCurrentIndex:(NSInteger)aIndex content:(id)aContent {
    _currentIndex = aIndex;
    _content = aContent;
}

- (id)conversionModel {
    id model = self.content;
    if ([self.content respondsToSelector:@selector(conversionModelForCellNode:)]) {
        model = [self.content conversionModelForCellNode:self.cellNode];
    }
    return model;
}

- (NSString *)heightCacheKey {
  NSString *key = [NSString stringWithFormat:@"%@%tu",NSStringFromClass(self.contentClass),self.currentIndex];
  if ([self.content respondsToSelector:@selector(cellType)]) {
    key = [NSString stringWithFormat:@"%@%tu",key,[self.content cellType]];
  }
  
  NSInteger type = [self.cellNode.cellClass cellTypeForContent:self.content];
  key = [NSString stringWithFormat:@"%@%tu",key,type];
  return key;
}

- (JYCellNode *)cellNode{
    return self.groupCellNode[self.currentIndex];
}

#pragma mark - cellNode 配置
+ (instancetype)nodeContentClass:(Class)aContentClass config:(void (^)(JYNode *node))aConfig{
    return [self nodeContentClass:aContentClass cellType:0 config:aConfig];
}

+ (instancetype)nodeContentClass:(Class)aContentClass cellType:(NSInteger)aCellType config:(void (^)(JYNode *node))aConfig{
    JYNode *node = [[JYNode alloc] init];
    node.jy_CellType = aCellType;
    [node bindContentClass:aContentClass];
    if (aConfig) {
        aConfig(node);
    }
    return node;
}

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

#pragma mark - JYBaseNodeProtocol
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

#pragma mark - 懒加载
- (NSMutableArray<JYCellNode *> *)groupCellNode{
    if (!_groupCellNode) {
        _groupCellNode = [[NSMutableArray alloc] init];
    }
    return _groupCellNode;
}

@end
