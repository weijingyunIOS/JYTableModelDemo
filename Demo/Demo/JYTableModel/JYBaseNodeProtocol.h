//
//  JYBaseNodeProtocol.h
//  Demo
//
//  Created by weijingyun on 2017/1/12.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYCellNode.h"

@protocol JYBaseNodeProtocol <NSObject>

// 对多cellNode间距的简单配置
- (void)configCellEdgeInsets:(UIEdgeInsets)edgeInsets marginColor:(UIColor *)marginColor;
- (void)configSeparatorColor:(UIColor *)lineColor;

// 获取当前cell
@property (nonatomic, strong, readonly) JYCellNode* cellNode;


// 转换模型
- (id)conversionModel;


@end
