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
@property (nonatomic, assign) CGFloat jy_CellHeight;

@end