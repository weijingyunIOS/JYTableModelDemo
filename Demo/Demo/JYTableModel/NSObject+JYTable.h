//
//  NSObject+JYTable.h
//  Demo
//
//  Created by weijingyun on 16/10/5.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (JYTable)

// 用于模型缓存cell行高，通过分类解耦
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *jy_CellHeightDic;

// 用于同类模型 区分不同cell
@property (nonatomic, assign) NSInteger jy_CellType;

@end
