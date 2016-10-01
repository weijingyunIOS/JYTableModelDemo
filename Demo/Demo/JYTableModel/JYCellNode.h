//
//  JYCellNode.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYNodeProtocol.h"

@interface JYCellNode : NSObject

// 根据 contentClass 与 cellType 生成的唯一表识用于快速定位
@property (nonatomic, copy, readonly) NSString *identifier;

// 模型class
@property (nonatomic, strong) Class<JYContentNodeProtocol> contentClass;

// 同一contentClass(需要实现- (NSInteger)cellType) 对应 不同的 cellType
@property (nonatomic, assign) NSInteger cellType;

// 模型对应的cell 由多个cell拼接 所以按数组排列
@property (nonatomic, strong) NSArray<Class>*groupClass;

+ (NSString *)identifierForContent:(id)aContent;

// 有些类型需要特殊处理
+ (Class)classForObject:(id)aObject;

@end
