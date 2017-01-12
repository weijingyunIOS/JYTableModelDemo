//
//  JYNodeProtocol.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+JYCellMargin.h"
#import "UICollectionViewCell+JYCell.h"
#import "NSObject+JYTable.h"
#import "JYCellNode.h"

@protocol JYTableCellProtocol <NSObject>

@optional
// 实现tableView高度计算， 如不实现则使用约束自动计算
+ (CGFloat)heightForContent:(id)aContent;
// 需要一些 cellNode 数据
+ (CGFloat)heightForContent:(id)aContent cellNode:(JYCellNode *)aCellNode;

// 实现数据设置
- (void)setCellContent:(id)aCellContent;

@property (nonatomic, weak) id cellDelegate;

// 是否为cell缓存高度  默认缓存，可重写该方法 return NO， 则不会缓存高度
+ (BOOL)jy_cacheHeight;

@end


@protocol JYContentProtocol <NSObject>

@optional
// 如果该 模型 有给不同 cell 使用，需要实现该方法区分 同cell 不同type高度也会做不同缓存
- (NSInteger)cellType;

// 模型转化，对应相应Cell 要转换成对应模型
- (id)conversionModelForCellNode:(JYCellNode *)aCellNode;

@end


// 以 JYGroupNode 必须遵守该协议
@protocol JYGroupContentProtocol <NSObject>

// 返回对应HeaderCell数据模型
- (id)conversionModelForGroupHeaderCellNode:(JYCellNode *)aCellNode;
// 返回中间 对应 数据模型 数组
- (NSArray<NSObject *> *)conversionModelForGroupCellNode:(JYCellNode *)aCellNode;
// 返回对应FooterCell数据模型
- (id)conversionModelForGroupFooterCellNode:(JYCellNode *)aCellNode;

@end

//// 组头cell Model 对应 只有一个
//@property (nonatomic, strong) JYCellNode *groupHeaderCellNode;
//// 中间以该 cell Model 对应 有多数据拼接
//@property (nonatomic, strong) JYCellNode *groupCellNode;
//// 组尾巴cell Model 对应 只有一个
//@property (nonatomic, strong) JYCellNode *groupFooterCellNode;

@protocol JYCollectionCellProtocol <NSObject>

@optional
// 实现CollectionCell  高度 计算
+ (CGFloat)heightForContent:(id)aContent withWidth:(CGFloat)width;
// 需要一些 cellNode 数据
+ (CGFloat)heightForContent:(id)aContent withWidth:(CGFloat)width cellNode:(JYCellNode *)aCellNode;

// 实现数据设置
- (void)setCellContent:(id)aCellContent;

@property (nonatomic, weak) id cellDelegate;

@end
