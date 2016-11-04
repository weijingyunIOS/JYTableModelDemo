//
//  UICollectionView+JYCollectionViewLayoutCell.m
//  MeiShuBaoPro
//
//  Created by weijingyun on 16/10/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UICollectionView+JYCollectionViewLayoutCell.h"
#import <objc/runtime.h>
#import "NSObject+JYTable.h"
#import "JYNodeProtocol.h"

static char kJyTemplateLayoutCellDic;

@interface UICollectionView()

@property (nonatomic, strong) NSMutableDictionary *jyTemplateLayoutCellDic;

@end

@implementation UICollectionView (JYCollectionViewLayoutCell)

- (CGFloat)jy_heightForCellClass:(Class)cellClass withIdentifier:(NSString *)identifier width:(CGFloat)width cacheBy:(NSObject *)model key:(NSString *)cachekey configuration:(void (^)(id cell))configuration{
  
  BOOL isCacheHeight = [cellClass jy_cacheHeight];
  CGFloat height = 0;
  if (isCacheHeight) {
    height = [model.jy_CellHeightDic[cachekey] floatValue];
    if (height > 0) {
      return height;
    }
  }
  
  height = [self jy_heightForCellClass:cellClass withIdentifier:identifier width:(CGFloat)width configuration:configuration];
  
  if (isCacheHeight) {
    model.jy_CellHeightDic[cachekey] = [NSNumber numberWithFloat:height];
  }
  
  return height;
}

- (CGFloat)jy_heightForCellClass:(Class)cellClass withIdentifier:(NSString *)identifier width:(CGFloat)contentViewWidth configuration:(void (^)(id cell))configuration {
  
  UICollectionViewCell *templateLayoutCell = [self jy_templateCellClass:cellClass forReuseIdentifier:identifier];
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


- (UICollectionViewCell *)jy_templateCellClass:(Class)cellClass forReuseIdentifier:(NSString *)identifier {

  UICollectionViewCell *templateLayoutCell = self.jyTemplateLayoutCellDic[identifier];
  if (templateLayoutCell == nil) {
    templateLayoutCell = [[cellClass alloc] init];
    [templateLayoutCell setValue:identifier forKey:@"reuseIdentifier"];
    templateLayoutCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    templateLayoutCell.translatesAutoresizingMaskIntoConstraints = NO;
    self.jyTemplateLayoutCellDic[identifier] = templateLayoutCell;
  }
  return templateLayoutCell;
}

#pragma mark - 属性绑定
- (void)setJyTemplateLayoutCellDic:(NSMutableDictionary *)jyTemplateLayoutCellDic{
  objc_setAssociatedObject(self,&kJyTemplateLayoutCellDic,jyTemplateLayoutCellDic,OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary *)jyTemplateLayoutCellDic{
  NSMutableDictionary *dicM = objc_getAssociatedObject(self, &kJyTemplateLayoutCellDic);
  if (dicM != nil) {
    return dicM;
  }
  dicM = [[NSMutableDictionary alloc] init];
  [self setJyTemplateLayoutCellDic:dicM];
  return objc_getAssociatedObject(self, &kJyTemplateLayoutCellDic);
}



@end
