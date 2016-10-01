//
//  JYNode.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYNode.h"

@interface JYNode()

// 根据 contentClass 与 cellType 生成的唯一表识用于快速定位
@property (nonatomic, copy) NSString *identifier;

// 外部展现时对应 的 cellClass
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) id content;

// CellNode
@property (nonatomic, strong) NSMutableArray<JYCellNode *>*groupCellNode;

@end

@implementation JYNode


- (void)recordCurrentIndex:(NSInteger)aIndex content:(id)aContent{
    _currentIndex = aIndex;
    _content = aContent;
}

- (JYCellNode *)cellNode{
    return self.groupCellNode[self.currentIndex];
}

#pragma mark - cellNode 配置
- (void)addCellClass:(Class)cellClass{
    JYCellNode *cellNode = [[JYCellNode alloc] init];
    cellNode.cellClass = cellClass;
    [self.groupCellNode addObject:cellNode];
}

- (void)addCellNode:(JYCellNode *)cellNode{
    [self.groupCellNode addObject:[cellNode copyNode]];
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

#pragma mark - private 用于框架内部调用
+ (NSString *)identifierForContent:(id)aContent{
    NSInteger cellType = 0;
    if ([aContent respondsToSelector:@selector(cellType)]) {
        cellType = [aContent cellType];
    }
    Class contentClass = [self classForObject:aContent];
    return [NSString stringWithFormat:@"%@_%tu",NSStringFromClass(contentClass),cellType];
}

- (NSString *)identifier{
    if (!_identifier) {
        _identifier = [NSString stringWithFormat:@"%@_%tu",NSStringFromClass(self.contentClass),self.cellType];
    }
    return _identifier;
}

// 必须检测字符串，要对字符串类型做特殊处理
+ (Class)classForObject:(id)aObject{
    if ([aObject isKindOfClass:[NSString class]]) {
        return [NSString class];
    }
    return [aObject class];
}

#pragma mark - 懒加载
- (NSMutableArray<JYCellNode *> *)groupCellNode{
    if (!_groupCellNode) {
        _groupCellNode = [[NSMutableArray alloc] init];
    }
    return _groupCellNode;
}

@end
