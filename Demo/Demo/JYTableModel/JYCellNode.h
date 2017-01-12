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
// 如果是Xib必须传
@property (nonatomic, strong) UINib *nib;

// 同一个cellClass 有多种形态，用jy_CellType来区分形态，从而注册cellIdentifier
@property (nonatomic, assign) NSInteger jy_CellType;

#pragma mark - 以下属性只对tableViewCell 有效
// 用于设置固定高度 的 cell
@property (nonatomic, assign) CGFloat cellHeight;
// 分割线颜色，不设置则没有分割线
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
// 如果四遍颜色一致的话，设置这个即可(性能更优)，某边颜色不同单独设置即可
@property (nonatomic, strong) UIColor *marginColor;

// 单独颜色不覆盖 边距 ，这种情况一般来说很少 用于多cell拼接时上下补空时 颜色不同
@property (nonatomic, strong) UIColor *topColor;
@property (nonatomic, strong) UIColor *leftColor;
@property (nonatomic, strong) UIColor *bottomColor;
@property (nonatomic, strong) UIColor *rightColor;

+ (instancetype)cellClass:(Class)aCellClass config:(void (^)(JYCellNode *cellNode))aConfig;

- (NSString *)cellIdentifier;
+ (NSInteger)cellTypeForIdentifier:(NSString *)identifier;

// 与类名相同的xib
- (UINib *)getDefaultNib;

@end
