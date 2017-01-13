//
//  JYNode.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYBaseNode.h"
#import "JYCellNode.h"
#import "JYNodeProtocol.h"

@interface JYNode : JYBaseNode


// 模型对应的cell 由多个cell拼接 所以按数组排列 UICollection 只能设置一个
@property (nonatomic, strong,readonly) NSMutableArray<JYCellNode *>*groupCellNode;


#pragma mark - cellNode 配置
// 数组元素只能是 JYCellNode 与 Class
- (void)bindContentClass:(Class)aContentClass cellNodes:(NSArray*)aNodes;
- (void)addCellClass:(Class)cellClass;
- (void)addCellNode:(JYCellNode *)cellNode;
// 数组元素只能是 JYCellNode 与 Class
- (void)addCellNodes:(NSArray*)aNodes;


@end
