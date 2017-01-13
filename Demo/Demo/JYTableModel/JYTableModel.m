//
//  JYTableModel.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYTableModel.h"
#import <objc/runtime.h>
#import "UITableViewCell+JYCellMargin.h"
#import "JYGroupNode.h"

@interface JYTableModel()

// 对应的tableViw
@property (nonatomic, weak) UITableView *tableView;

// 记录cell的代理
@property (nonatomic, weak) id cellDelegate;

// cell 的配置信息
@property (nonatomic, strong) NSMutableDictionary<NSString * ,JYBaseNode *> *nodeCache;

// 所有的数据源
@property (nonatomic, strong) NSMutableArray<NSMutableArray*>* allContents;

// 多cell拼接需要进行复杂计算，该标记是 为 Content － cell 一对一时 节省计算
@property (nonatomic, assign) BOOL isMoreCell;

// 是否隐藏每组最后的分割线
@property (nonatomic, assign) BOOL hiddenLast;


@end

@implementation JYTableModel


#pragma mark -  注册cell tableView
- (void)registCellNodes:(NSArray<JYBaseNode *> *)nodes byTableView:(UITableView *)tableView{
  [self registCellNodes:nodes byTableView:tableView cellDelegate:nil];
}

- (void)registCellNodes:(NSArray<JYBaseNode *> *)nodes byTableView:(UITableView *)tableView cellDelegate:(id)cellDelegate{
  
    _cellDelegate = cellDelegate;
    _tableView = tableView;
    self.isMoreCell = NO;
    [nodes enumerateObjectsUsingBlock:^(JYBaseNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[JYNode class]]) {
            [self registNode:(JYNode *)obj byTableView:tableView];
        }else if ([obj isKindOfClass:[JYGroupNode class]]) {
            [self registGroupNode:(JYGroupNode *)obj byTableView:tableView];
        }
    }];
    
    // 取消系统分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)registGroupNode:(JYGroupNode *)node byTableView:(UITableView *)tableView {
    self.isMoreCell = YES;
    [self registCellNode:node.groupHeaderCellNode byTableView:tableView];
    [self registCellNode:node.groupCellNode byTableView:tableView];
    [self registCellNode:node.groupFooterCellNode byTableView:tableView];
    [self.nodeCache setObject:node forKey:node.identifier];
}

- (void)registNode:(JYNode *)node byTableView:(UITableView *)tableView {
    
    if (node.groupCellNode.count >1) {
        self.isMoreCell = YES;
    }
    [node.groupCellNode enumerateObjectsUsingBlock:^(JYCellNode* cellNode, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registCellNode:cellNode byTableView:tableView];
    }];
    [self.nodeCache setObject:node forKey:node.identifier];
}

- (void)registCellNode:(JYCellNode *)cellNode byTableView:(UITableView *)tableView {

    if (cellNode.nib != nil) {
        [tableView registerNib:cellNode.nib forCellReuseIdentifier:[cellNode cellIdentifier]];
    }else {
        [tableView registerClass:cellNode.cellClass forCellReuseIdentifier:[cellNode cellIdentifier]];
    }
}

#pragma mark - 辅助设置 需要先执行 registCellNodes
- (void)configCellEdgeInsets:(UIEdgeInsets)edgeInsets marginColor:(UIColor *)marginColor{
    [self.nodeCache enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, JYBaseNode * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj configCellEdgeInsets:edgeInsets marginColor:marginColor];
    }];
}

// 添加分割线，不调用则没有分割线, 是否隐藏分割线在每组最后一个cell
- (void)configSeparatorColor:(UIColor *)lineColor hiddenLast:(BOOL)hidden{
    [self.nodeCache enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, JYBaseNode * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj configSeparatorColor:lineColor];
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

- (BOOL)isEmpty{
  return !(self.allContents.count > 0 && self.allContents.firstObject.count > 0);
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
    return [self heightForRowAtIndexPath:indexPath config:nil];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UITableViewCell *aCell,JYBaseNode* aNode))aConfig{
    
    CGFloat height = 0.;
    JYBaseNode *node = [self getCellNodeAtIndexPath:indexPath];
    JYCellNode *cellNode = node.getCurrentCellNode;
    if (cellNode.cellHeight > 0) {
        height = cellNode.cellHeight;
    }else if (class_getClassMethod(node.getCurrentCellNode.cellClass, @selector(heightForContent:)) != nil){
        height = [node.getCurrentCellNode.cellClass heightForContent:node.content];
    }else if (class_getClassMethod(node.getCurrentCellNode.cellClass, @selector(heightForContent:cellNode:)) != nil){
        height = [node.getCurrentCellNode.cellClass heightForContent:node.content cellNode:node.getCurrentCellNode];
    }else{
        if (self.tableView.frame.size.width == 0) { // 没宽度无法算高度
          CGRect frame = self.tableView.frame;
          frame.size.width = [UIScreen mainScreen].bounds.size.width;
          self.tableView.frame = frame;
        }
        NSString *key = [node heightCacheKey];
       height = [self.tableView jy_heightForCellClass:cellNode.cellClass withIdentifier:[cellNode cellIdentifier] cacheContent:node.content key:key configuration:^(id cell) {
         [self configCell:cell forNode:node AtIndexPath:indexPath config:aConfig];
         if (aConfig) {
             aConfig(cell,node);
         }
       }];
    }

    height += node.getCurrentCellNode.edgeInsets.top + node.getCurrentCellNode.edgeInsets.bottom;
    return height;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellForRowAtIndexPath:indexPath config:nil];
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UITableViewCell *aCell,JYBaseNode* aNode))aConfig{
    
    JYBaseNode *node = [self getCellNodeAtIndexPath:indexPath];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[node.getCurrentCellNode cellIdentifier] forIndexPath:indexPath];
    [self configCell:cell forNode:node AtIndexPath:indexPath config:aConfig];
    return cell;
}

- (void)configCell:(UITableViewCell *)cell forNode:(JYBaseNode *)node AtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UITableViewCell *aCell,JYBaseNode* aNode))aConfig{
  
    // 边距 分割线 以及颜色设置
    JYCellNode *cellNode = node.getCurrentCellNode;
    cell.edgeInsets = cellNode.edgeInsets;
    cell.jy_indexPath = indexPath;
    [cell configEdgeInsetsColor:cellNode.marginColor];
    [cell configTopColor:cellNode.topColor leftColor:cellNode.leftColor bottomColor:cellNode.bottomColor rightColor:cellNode.rightColor];
    BOOL hidden = indexPath.row == [self numberOfRowsInSection:indexPath.section] - 1;
    [cell configSeparatorColor:cellNode.lineColor hidden:hidden || cellNode.lineColor == nil];
    
    //  内容设置
    if ([cell respondsToSelector:@selector(setCellContent:)]) {
        [(id)cell setCellContent:node.content];
    }else if ([cell respondsToSelector:@selector(setCellContent:metaContent:cellNode:)]) {
        [(id)cell setCellContent:node.content metaContent:node.metaContent cellNode:node.getCurrentCellNode];
    }
  
    if ([cell respondsToSelector:@selector(setCellDelegate:)]) {
      [(id)cell setCellDelegate:self.cellDelegate];
    }
  
    if (aConfig) {
      aConfig(cell,node);
    }
}

- (void)reomveObjectAtIndexPath:(NSIndexPath *)aIndexPath{
    NSMutableArray* contents = [self contentsAtInSection:aIndexPath.section];
    JYBaseNode *node = [self getCellNodeAtIndexPath:aIndexPath];
    [contents removeObject:node.content];
}

- (JYBaseNode *)getCellNodeAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *contents = [self contentsAtInSection:indexPath.section];
    if (!self.isMoreCell) {
        id content = contents[indexPath.row];
        JYNode *node = (JYNode *)self.nodeCache[[JYNode identifierForContent:content]];
        NSAssert([node isKindOfClass:[JYNode class]], @"只有JYNode 才有这种情况");
        [node recordCurrentIndex:0 content:content metaContent:content];
        return node;
    }
    __block NSInteger index = -1;
    __block JYBaseNode *node = nil;
    [contents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        index += [self cellCountForContent:obj];
        if (index >= indexPath.row) {
            
            node = self.nodeCache[[JYBaseNode identifierForContent:obj]];
            if ([node isKindOfClass:[JYNode class]]) {
                
                JYNode *ynode = (JYNode *)node;
                NSInteger cellIndex = ynode.groupCellNode.count - (index - indexPath.row) - 1;
                id content = obj;
                if ([obj respondsToSelector:@selector(conversionModelForCellNode:)]) {
                    content = [obj conversionModelForCellNode:ynode.groupCellNode[cellIndex]];
                }
                [ynode recordCurrentIndex:cellIndex content:content metaContent:obj];
                
            }else if ([node isKindOfClass:[JYGroupNode class]]) {
                JYGroupNode *groupNode = (JYGroupNode *)node;
                NSArray *group = [obj conversionModelForGroupCellNode:groupNode.groupCellNode];
                NSInteger currentIndex = group.count + 2 - (index - indexPath.row) - 1;
                if (currentIndex == 0) {
                    [groupNode recordCurrentIndex:0 content:[obj conversionModelForGroupHeaderCellNode:groupNode.groupHeaderCellNode]metaContent:obj];
                }else if (currentIndex == (group.count + 2 -1)) {
                    [groupNode recordCurrentIndex:2 content:[obj conversionModelForGroupHeaderCellNode:groupNode.groupFooterCellNode]metaContent:obj];
                }else {
                    [groupNode recordCurrentIndex:1 content:[obj conversionModelForGroupHeaderCellNode:groupNode.groupCellNode]metaContent:obj];
                }
            }
            
            *stop = YES;
        }
    }];
    return node;
}

- (NSInteger)caculateCountInSection:(NSInteger)section
{
    
    NSArray* contents = [self.allContents objectAtIndex:section];
    if (!self.isMoreCell) {
        return contents.count;
    }
    __block NSInteger count = 0;
    [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        count += [self cellCountForContent:obj];
    }];
    return count;
}

- (NSInteger)cellCountForContent:(id)aContent
{
    JYBaseNode *node = self.nodeCache[[JYBaseNode identifierForContent:aContent]];
    NSAssert(node != nil, @"node 为空 检查identifierForContent生成");
    if ([node isKindOfClass:[JYNode class]]) {
        return ((JYNode *)node).groupCellNode.count;
    }
    NSAssert([node isKindOfClass:[JYGroupNode class]], @"必定是JYGroupNode");
    JYGroupNode *groupNode = (JYGroupNode *)node;
    NSArray *group = [aContent conversionModelForGroupCellNode:groupNode.groupCellNode];
    return group.count + 2;
}

// 必须检测字符串，要对字符串类型做特殊处理
- (Class)classForObject:(id)aObject{
    return [JYBaseNode classForObject:aObject];
}
#pragma mark - 懒加载
- (NSMutableDictionary<NSString *,JYBaseNode *> *)nodeCache{
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
