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

@property (nonatomic, strong) UIColor *topColor;
@property (nonatomic, strong) UIColor *leftColor;
@property (nonatomic, strong) UIColor *bottomColor;
@property (nonatomic, strong) UIColor *rightColor;

// 拷贝一份
- (instancetype)copyNode;

@end
