//
//  JYNode.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYCellNode.h"
#import "JYNodeProtocol.h"

@interface JYNode : NSObject

// 模型class
@property (nonatomic, strong, readonly) Class contentClass;

// 同一contentClass(需要实现- (NSInteger)cellType) 对应 不同的 cellType
@property (nonatomic, assign) NSInteger cellType;

// 模型对应的cell 由多个cell拼接 所以按数组排列
@property (nonatomic, strong,readonly) NSMutableArray<JYCellNode *>*groupCellNode;

// 外部展现时对应 的 cellClass 与 数据
@property (nonatomic, strong, readonly) JYCellNode* cellNode;
@property (nonatomic, strong, readonly) id content;

#pragma mark - cellNode 配置
+ (instancetype)nodeContentClass:(Class)aContentClass config:(void (^)(JYNode *node))aConfig;
+ (instancetype)nodeContentClass:(Class)aContentClass cellType:(NSInteger)aCellType config:(void (^)(JYNode *node))aConfig;
// 数组元素只能是 JYCellNode 与 Class
- (void)bindContentClass:(Class)aContentClass cellNodes:(NSArray*)aNodes;
- (void)bindContentClass:(Class)aContentClass;
- (void)addCellClass:(Class)cellClass;
- (void)addCellNode:(JYCellNode *)cellNode;
// 数组元素只能是 JYCellNode 与 Class
- (void)addCellNodes:(NSArray*)aNodes;


#pragma mark - private 用于框架内部调用
- (void)recordCurrentIndex:(NSInteger)aIndex content:(id)aContent;

// 根据 contentClass 与 cellType 生成的唯一表识用于快速定位
@property (nonatomic, copy, readonly) NSString *identifier;

+ (NSString *)identifierForContent:(id)aContent;

// 有些类型需要特殊处理
+ (Class)classForObject:(id)aObject;

@end
