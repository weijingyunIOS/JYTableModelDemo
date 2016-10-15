//
//  UICollectionViewCell+JYCell.h
//  MeiShuBaoPro
//
//  Created by weijingyun on 16/10/8.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (JYCell)

// 当前cell所在的indexPath
@property (nonatomic, strong) NSIndexPath *jy_indexPath;

@end
