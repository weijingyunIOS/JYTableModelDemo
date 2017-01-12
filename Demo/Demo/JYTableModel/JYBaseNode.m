//
//  JYBaseNode.m
//  Demo
//
//  Created by weijingyun on 2017/1/12.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "JYBaseNode.h"
#import "NSObject+JYTable.h"
#import "JYNodeProtocol.h"

@interface JYBaseNode ()

// 根据 contentClass 与 cellType 生成的唯一表识用于快速定位
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) Class contentClass;


// 外部展现时对应 的 cellClass
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) id content;


@end

@implementation JYBaseNode

+ (instancetype)nodeContentClass:(Class)aContentClass config:(void (^)(__kindof JYBaseNode *node))aConfig{
    return [self nodeContentClass:aContentClass cellType:0 config:aConfig];
}

+ (instancetype)nodeContentClass:(Class)aContentClass cellType:(NSInteger)aCellType config:(void (^)(__kindof JYBaseNode *node))aConfig {
    JYBaseNode *node = [[self alloc] init];
    node.jy_CellType = aCellType;
    [node bindContentClass:aContentClass];
    if (aConfig) {
        aConfig(node);
    }
    return node;
}

- (void)bindContentClass:(Class)aContentClass{
    _contentClass = aContentClass;
}


#pragma mark - private 用于框架内部调用
- (void)recordCurrentIndex:(NSInteger)aIndex content:(id)aContent {
    _currentIndex = aIndex;
    _content = aContent;
}

- (NSString *)heightCacheKey {
    NSString *key = [NSString stringWithFormat:@"%@%tu",NSStringFromClass(self.contentClass),self.currentIndex];
    if ([self.content respondsToSelector:@selector(cellType)]) {
        key = [NSString stringWithFormat:@"%@%tu",key,[self.content cellType]];
    }
    
    NSInteger type = [self.cellNode.cellClass cellTypeForContent:self.content];
    key = [NSString stringWithFormat:@"%@%tu",key,type];
    return key;
}

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
