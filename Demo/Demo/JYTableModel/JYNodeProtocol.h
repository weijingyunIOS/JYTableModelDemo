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

@protocol JYTableCellProtocol <NSObject>

@optional
// 实现tableView高度计算， 如不实现则使用约束自动计算
+ (CGFloat)heightForContent:(id)aContent;

// 实现数据设置
- (void)setCellContent:(id)aCellContent;

@property (nonatomic, weak) id cellDelegate;

@end


@protocol JYContentProtocol <NSObject>

@optional
// 如果该 模型 有给不同 cell 使用，需要实现该方法区分 同cell 不同type高度也会做不同缓存
- (NSInteger)cellType;

// 模型转化，对应相应Cell 要转换成对应模型
- (id)conversionModelForCellClass:(Class)aCellClass;

@end

@protocol JYCollectionCellProtocol <NSObject>

@optional
// 实现CollectionCell  高度 计算
+ (CGFloat)heightForContent:(id)aContent withWidth:(CGFloat)width;

// 实现数据设置
- (void)setCellContent:(id)aCellContent;

@property (nonatomic, weak) id cellDelegate;

@end
