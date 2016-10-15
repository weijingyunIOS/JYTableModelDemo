//
//  UICollectionView+JYCollectionViewLayoutCell.h
//  MeiShuBaoPro
//
//  Created by weijingyun on 16/10/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (JYCollectionViewLayoutCell)

- (CGFloat)jy_heightForCellClass:(Class)cellClass withIdentifier:(NSString *)identifier width:(CGFloat)width cacheBy:(NSObject *)key configuration:(void (^)(id cell))configuration;

@end
