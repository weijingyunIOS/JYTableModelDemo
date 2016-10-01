//
//  JYTableModel.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYTableModel.h"

@interface JYTableModel()

// 对应的tableViw
@property (nonatomic, weak) UITableView *tableView;

// cell 的配置信息
@property (nonatomic, strong) NSMutableDictionary<NSString * ,JYCellNode *> *nodeCache;

// 所有的数据源
@property (nonatomic, strong) NSMutableArray<NSMutableArray*>* allContents;

@end

@implementation JYTableModel


#pragma mark -  注册cell tableView
- (void)registCellNodes:(NSArray<JYCellNode*>*)nodes byTableView:(UITableView*)tableView{
    _tableView = tableView;
    [nodes enumerateObjectsUsingBlock:^(JYCellNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.groupClass enumerateObjectsUsingBlock:^(Class  _Nonnull groupClass, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerClass:groupClass forCellReuseIdentifier:NSStringFromClass(groupClass)];
        }];
        [self.nodeCache setObject:obj forKey:obj.identifier];
    }];
}

#pragma mark - 数据操作
- (void)setContents:(NSArray *)aContents
{
    [self setContents:aContents atSection:0];
}

- (void)addContents:(NSArray *)aContents
{
    [self addContents:aContents atSection:0];
}

- (void)setContents:(NSArray *)aContents atSection:(NSInteger)aSection
{
    NSMutableArray* contents = [self contentsAtInSection:aSection];
    [contents removeAllObjects];
    [contents addObjectsFromArray:aContents];
}

- (void)addContents:(NSArray *)aContents atSection:(NSInteger)aSection
{
    NSMutableArray* contents = [self contentsAtInSection:aSection];
    [contents addObjectsFromArray:aContents];
}

//不存在就建一个新的数组
- (NSMutableArray *)contentsAtInSection:(NSInteger)aSection
{
    NSMutableArray* contents = nil;
    if ([self.allContents count] > aSection) {
        contents = [self.allContents objectAtIndex:aSection];
    } else {
        if (self.allContents.count == aSection) {
            contents = [NSMutableArray array];
            [self.allContents addObject:contents];
        }
    }
    NSAssert(contents, @"插入的aSection超出了现有的");
    return contents;
}

#pragma mark - Table View 辅助计算
- (NSInteger)numberOfSections{
    return self.allContents.count;
}

// 因为存在 多cell拼接 所以要做偏移计算
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self caculateCountInSection:section];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

- (JYCellNode *)contentInfoAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *contents = [self contentsAtInSection:indexPath.section];
    __block NSInteger index = -1;
    __block JYCellNode *node = nil;
    [contents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        index += [self cellCountForContent:obj];
        if (index >= indexPath.row) {
            
            node = self.nodeCache[[JYCellNode identifierForContent:obj]];
            NSInteger cellIndex = node.groupClass.count - (index - indexPath.row) - 1;
            
            *stop = YES;
        }
    }];
    return node;
}

- (NSInteger)caculateCountInSection:(NSInteger)section
{
    NSArray* contents = [self.allContents objectAtIndex:section];
    
    __block NSInteger count = 0;
    [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        count += [self cellCountForContent:obj];
    }];
    return count;
}

- (NSInteger)cellCountForContent:(id)aContent
{
    JYCellNode *node = self.nodeCache[[JYCellNode identifierForContent:aContent]];
    return node.groupClass.count;
}

// 必须检测字符串，要对字符串类型做特殊处理
- (Class)classForObject:(id)aObject{
    return [JYCellNode classForObject:aObject];
}
#pragma mark - 懒加载
- (NSMutableDictionary<NSString *,JYCellNode *> *)nodeCache{
    if (!_nodeCache) {
        _nodeCache = [[NSMutableDictionary alloc] init];
    }
    return _nodeCache;
}

- (NSMutableArray<NSMutableArray *> *)allContents{
    if (!_allContents) {
        _allContents = [[NSMutableArray alloc] init];
    }
    return _allContents;
}
@end
