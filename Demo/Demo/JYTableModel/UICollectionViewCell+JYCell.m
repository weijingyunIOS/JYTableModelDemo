//
//  UICollectionViewCell+JYCell.m
//  MeiShuBaoPro
//
//  Created by weijingyun on 16/10/8.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UICollectionViewCell+JYCell.h"
#import <objc/runtime.h>

static char kJYIndexPath;

@implementation UICollectionViewCell (JYCell)

- (void)setJy_indexPath:(NSIndexPath *)jy_indexPath{
  objc_setAssociatedObject(self,&kJYIndexPath,jy_indexPath,OBJC_ASSOCIATION_RETAIN);
}

- (NSIndexPath *)jy_indexPath{
  return objc_getAssociatedObject(self, &kJYIndexPath);
}

@end
