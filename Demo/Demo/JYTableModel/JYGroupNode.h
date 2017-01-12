//
//  JYGroupNode.h
//  Demo
//
//  Created by weijingyun on 2017/1/12.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "JYBaseNode.h"
#import "JYCellNode.h"

/**
 * 只针对 UITableViewCell 配置 不支持  UICollectionView
 * contentClass 必须遵守 JYGroupContentProtocol 协议
 */

@interface JYGroupNode : JYBaseNode

// 模型class
@property (nonatomic, strong, readonly) Class contentClass;
// 组头cell Model 对应 只有一个
@property (nonatomic, strong) JYCellNode *groupHeaderCellNode;
// 中间以该 cell Model 对应 有多数据拼接
@property (nonatomic, strong) JYCellNode *groupCellNode;
// 组尾巴cell Model 对应 只有一个
@property (nonatomic, strong) JYCellNode *groupFooterCellNode;


@end
