//
//  JYCellNode.m
//  Demo
//
//  Created by weijingyun on 16/10/2.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYCellNode.h"
@implementation JYCellNode

+ (instancetype)cellClass:(Class)aCellClass config:(void (^)(JYCellNode *cellNode))aConfig{
    JYCellNode *node = [[JYCellNode alloc] init];
    node.cellClass = aCellClass;
    if (aConfig) {
        aConfig(node);
    }
    return node;
}

- (NSString *)cellIdentifier{
  return [NSString stringWithFormat:@"%@_%tu",NSStringFromClass(self.cellClass),self.cellType];
}

+ (NSInteger)cellTypeForIdentifier:(NSString *)identifier{
  NSArray * array = [identifier componentsSeparatedByString:@"_"];
  return [array.lastObject integerValue];
}

@end
