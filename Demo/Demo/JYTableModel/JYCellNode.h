//
//  JYCellNode.h
//  Demo
//
//  Created by weijingyun on 16/10/2.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCellNode : NSObject

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

// 分割线颜色，不设置则没有分割线
@property (nonatomic, strong) UIColor *lineColor;

// 如果四遍颜色一致的话，设置这个即可(性能更优)，某边颜色不同单独设置即可
@property (nonatomic, strong) UIColor *marginColor;

// 单独颜色不覆盖 边距 ，这种情况一般来说很少 用于多cell拼接时上下补空时 颜色不同
@property (nonatomic, strong) UIColor *topColor;
@property (nonatomic, strong) UIColor *leftColor;
@property (nonatomic, strong) UIColor *bottomColor;
@property (nonatomic, strong) UIColor *rightColor;

+ (instancetype)cellClass:(Class)aCellClass config:(void (^)(JYCellNode *cellNode))aConfig;

@end
