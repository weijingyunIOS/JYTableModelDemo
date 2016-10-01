//
//  JYCellNodeProtocol.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYCellNodeProtocol <NSObject>

@optional
// 实现tableView高度计算， 如不实现则使用约束自动计算
+ (CGFloat)heightForContent:(id)aContent;

@end


@protocol JYContentNodeProtocol <NSObject>


@optional
// 如果该 模型 有给不同 cell 使用，需要实现该方法区分
- (NSInteger)cellType;

@end
