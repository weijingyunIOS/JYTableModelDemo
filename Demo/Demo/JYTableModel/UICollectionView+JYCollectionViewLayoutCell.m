//
//  UICollectionView+JYCollectionViewLayoutCell.m
//  MeiShuBaoPro
//
//  Created by weijingyun on 16/10/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UICollectionView+JYCollectionViewLayoutCell.h"
#import "NSObject+JYTable.h"

#define kCellHeight @"kCellHeight"
@implementation UICollectionView (JYCollectionViewLayoutCell)

- (CGFloat)jy_heightForCellClass:(Class)cellClass withIdentifier:(NSString *)identifier width:(CGFloat)width cacheBy:(NSObject *)key configuration:(void (^)(id cell))configuration{
  CGFloat height = [key.jy_CellHeightDic[kCellHeight] floatValue];
  if (height > 0) {
    return height;
  }
  
  height = [self jy_heightForCellClass:cellClass withIdentifier:identifier width:(CGFloat)width configuration:configuration];
  key.jy_CellHeightDic[kCellHeight] = [NSNumber numberWithFloat:height];
  return height;
}

- (CGFloat)jy_heightForCellClass:(Class)cellClass withIdentifier:(NSString *)identifier width:(CGFloat)contentViewWidth configuration:(void (^)(id cell))configuration {
  UICollectionViewCell *templateLayoutCell = [[cellClass alloc] init];
  [templateLayoutCell setValue:identifier forKey:@"reuseIdentifier"];
  if (configuration) {
    configuration(templateLayoutCell);
  }
  
  // Manually calls to ensure consistent behavior with actual cells (that are displayed on screen).
  [templateLayoutCell prepareForReuse];
  
  // Customize and provide content for our template cell.
  if (configuration) {
    configuration(templateLayoutCell);
  }

  CGSize fittingSize = CGSizeZero;
  
    if (contentViewWidth > 0) {
      NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:templateLayoutCell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
      
      [templateLayoutCell.contentView addConstraint:widthFenceConstraint];
      // Auto layout engine does its math
      fittingSize = [templateLayoutCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
      [templateLayoutCell.contentView removeConstraint:widthFenceConstraint];
    }

  return fittingSize.height;
}

@end
