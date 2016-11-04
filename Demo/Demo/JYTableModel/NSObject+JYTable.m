//
//  NSObject+JYTable.m
//  Demo
//
//  Created by weijingyun on 16/10/5.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "NSObject+JYTable.h"
#import <objc/runtime.h>

static char kJy_CellHeightDic;
static char kJy_CellType;

@implementation NSObject (JYTable)


#pragma mark - 属性方法实现
- (void)setJy_CellType:(NSInteger)jy_CellType{
  objc_setAssociatedObject(self,&kJy_CellType,[NSNumber numberWithInteger:jy_CellType],OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)jy_CellType{
  return [objc_getAssociatedObject(self, &kJy_CellType) integerValue];
}

- (void)setJy_CellHeightDic:(NSMutableDictionary<NSString *, NSNumber *> *)jy_CellHeightDic{
    objc_setAssociatedObject(self,&kJy_CellHeightDic,jy_CellHeightDic,OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary<NSString *, NSNumber *> *)jy_CellHeightDic{
  NSMutableDictionary *dicM = objc_getAssociatedObject(self, &kJy_CellHeightDic);
  if (dicM != nil) {
    return dicM;
  }
  dicM = [[NSMutableDictionary alloc] init];
  [self setJy_CellHeightDic:dicM];
  return objc_getAssociatedObject(self, &kJy_CellHeightDic);
}

@end
