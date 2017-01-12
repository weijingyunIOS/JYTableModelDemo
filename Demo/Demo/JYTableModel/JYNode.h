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

// 外部展现时对应 的 cellClass 与 数据
@property (nonatomic, strong, readonly) JYCellNode* cellNode;
@property (nonatomic, strong, readonly) id content;

#pragma mark - cellNode 配置
+ (instancetype)nodeContentClass:(Class)aContentClass config:(void (^)(JYNode *node))aConfig;
+ (instancetype)nodeContentClass:(Class)aContentClass cellType:(NSInteger)aCellType config:(void (^)(JYNode *node))aConfig;
// 数组元素只能是 JYCellNode 与 Class
- (void)bindContentClass:(Class)aContentClass cellNodes:(NSArray*)aNodes;
- (void)addCellClass:(Class)cellClass;
- (void)addCellNode:(JYCellNode *)cellNode;
// 数组元素只能是 JYCellNode 与 Class
- (void)addCellNodes:(NSArray*)aNodes;

#pragma mark - JYBaseNodeProtocol
// 对cellNode间距的简单配置
- (void)configCellEdgeInsets:(UIEdgeInsets)edgeInsets marginColor:(UIColor *)marginColor;

// 分割线颜色配置
- (void)configSeparatorColor:(UIColor *)lineColor;

#pragma mark - private 用于框架内部调用
- (void)recordCurrentIndex:(NSInteger)aIndex content:(id)aContent;
- (id)conversionModel; // 执行recordCurrentIndex 后有效
- (NSString *)heightCacheKey;


@end
