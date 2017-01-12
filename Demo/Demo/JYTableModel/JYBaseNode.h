//
//  JYBaseNode.h
//  Demo
//
//  Created by weijingyun on 2017/1/12.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBaseNodeProtocol.h"

@interface JYBaseNode : NSObject <JYBaseNodeProtocol>

// 模型class
@property (nonatomic, strong, readonly) Class contentClass;

// 同一contentClass(需要实现- (NSInteger)jy_CellType) 对应 不同的 jy_CellType
@property (nonatomic, assign) NSInteger jy_CellType;

- (void)bindContentClass:(Class)aContentClass;

#pragma mark - private 用于框架内部调用
// 根据 contentClass 与 cellType 生成的唯一表识用于快速定位
@property (nonatomic, copy, readonly) NSString *identifier;
+ (NSString *)identifierForContent:(id)aContent;
// 有些类型需要特殊处理
+ (Class)classForObject:(id)aObject;

@end
