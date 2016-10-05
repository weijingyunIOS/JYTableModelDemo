//
//  NSObject+JYTable.m
//  Demo
//
//  Created by weijingyun on 16/10/5.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "NSObject+JYTable.h"
#import <objc/runtime.h>

static char kJYCellHeight;

@implementation NSObject (JYTable)


#pragma mark - 属性方法实现
- (void)setJy_CellHeight:(CGFloat)jy_CellHeight{
    objc_setAssociatedObject(self,&kJYCellHeight,[NSNumber numberWithDouble:jy_CellHeight],OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)jy_CellHeight{
   return [objc_getAssociatedObject(self, &kJYCellHeight) doubleValue];
}

@end
