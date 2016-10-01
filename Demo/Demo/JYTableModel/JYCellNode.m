//
//  JYCellNode.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYCellNode.h"

@interface JYCellNode()

// 根据 contentClass 与 cellType 生成的唯一表识用于快速定位
@property (nonatomic, copy) NSString *identifier;

@end

@implementation JYCellNode


+ (NSString *)identifierForContent:(id)aContent{
    NSInteger cellType = 0;
    if ([aContent respondsToSelector:@selector(cellType)]) {
        cellType = [aContent cellType];
    }
    Class contentClass = [self classForObject:aContent];
    return [NSString stringWithFormat:@"%@_%tu",NSStringFromClass(contentClass),cellType];
}

- (NSString *)identifier{
    if (!_identifier) {
        _identifier = [NSString stringWithFormat:@"%@_%tu",NSStringFromClass(self.contentClass),self.cellType];
    }
    return _identifier;
}

// 必须检测字符串，要对字符串类型做特殊处理
+ (Class)classForObject:(id)aObject{
    if ([aObject isKindOfClass:[NSString class]]) {
        return [NSString class];
    }
    return [aObject class];
}

@end
