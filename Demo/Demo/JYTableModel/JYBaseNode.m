//
//  JYBaseNode.m
//  Demo
//
//  Created by weijingyun on 2017/1/12.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "JYBaseNode.h"
#import "NSObject+JYTable.h"

@interface JYBaseNode ()

// 根据 contentClass 与 cellType 生成的唯一表识用于快速定位
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) Class contentClass;

@end

@implementation JYBaseNode

- (void)bindContentClass:(Class)aContentClass{
    _contentClass = aContentClass;
}

#pragma mark - private 用于框架内部调用
+ (NSString *)identifierForContent:(NSObject *)aContent{
    
    Class contentClass = [self classForObject:aContent];
//    NSLog(@"获取%@",[NSString stringWithFormat:@"%@_%tu",NSStringFromClass(contentClass),aContent.jy_CellType]);
    return [NSString stringWithFormat:@"%@_%tu",NSStringFromClass(contentClass),aContent.jy_CellType];
}

- (NSString *)identifier{
    if (!_identifier) {
        _identifier = [NSString stringWithFormat:@"%@_%tu",NSStringFromClass(self.contentClass),self.jy_CellType];
//        NSLog(@"生成%@",_identifier);
    }
    return _identifier;
}

// 必须检测字符串，要对字符串类型做特殊处理
+ (Class)classForObject:(id)aObject{
    if ([aObject isKindOfClass:[NSString class]]) {
        //        return [aObject isKindOfClass:[NSMutableString class]] ? [NSMutableString class] : [NSString class];
        return [NSString class];
    }else if ([aObject isKindOfClass:[NSArray class]]) {
        //        return [aObject isKindOfClass:[NSMutableArray class]] ? [NSMutableArray class] : [NSArray class];
        return [NSArray class];
    }else if ([aObject isKindOfClass:[NSDictionary class]]) {
        //        return [aObject isKindOfClass:[NSMutableDictionary class]] ? [NSMutableDictionary class] : [NSDictionary class];
        return [NSMutableArray class];
    }
    return [aObject class];
}


@end
