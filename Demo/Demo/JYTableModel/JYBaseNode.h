//
//  JYBaseNode.h
//  Demo
//
//  Created by weijingyun on 2017/1/12.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYCellNode.h"

@interface JYBaseNode : NSObject

// 模型class
@property (nonatomic, strong, readonly) Class contentClass;

// 同一contentClass(需要实现- (NSInteger)jy_CellType) 对应 不同的 jy_CellType
@property (nonatomic, assign) NSInteger jy_CellType;

// 外部展现时对应 的 cellClass
@property (nonatomic, assign, readonly) NSInteger currentIndex; // 当前index 用于 - (JYCellNode *)getCurrentCellNode;
@property (nonatomic, strong, readonly) id content;     // 当前cell要展现的数据
@property (nonatomic, strong, readonly) id metaContent; // 元数据 如未做处理，content 与 metaContent一样

#pragma mark - 简便的创建方法提供
+ (instancetype)nodeContentClass:(Class)aContentClass config:(void (^)(__kindof JYBaseNode *node))aConfig;
+ (instancetype)nodeContentClass:(Class)aContentClass cellType:(NSInteger)aCellType config:(void (^)(__kindof JYBaseNode *node))aConfig;
- (void)bindContentClass:(Class)aContentClass;

#pragma mark - 对node的整体配置 需要子类重写
// 对cellNode间距的简单配置
- (void)configCellEdgeInsets:(UIEdgeInsets)edgeInsets marginColor:(UIColor *)marginColor;

// 分割线颜色配置
- (void)configSeparatorColor:(UIColor *)lineColor;

// 获取当前cell
- (JYCellNode *)getCurrentCellNode;


#pragma mark - private 用于框架内部调用
- (void)recordCurrentIndex:(NSInteger)aIndex content:(id)aContent metaContent:(id)aMetaContent;

// 高度缓存key 生成
- (NSString *)heightCacheKey;

// 根据 contentClass 与 cellType 生成的唯一表识用于快速定位
@property (nonatomic, copy, readonly) NSString *identifier;
+ (NSString *)identifierForContent:(id)aContent;
// 有些类型需要特殊处理
+ (Class)classForObject:(id)aObject;

@end
