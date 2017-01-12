  //
//  JYCollectionModel.m
//  MeiShuBaoPro
//
//  Created by weijingyun on 16/10/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "JYCollectionModel.h"
#import <objc/runtime.h>
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import "UICollectionView+JYCollectionViewLayoutCell.h"
#import "UICollectionViewCell+JYCell.h"
@interface JYCollectionModel()

// 对应的tableViw
@property (nonatomic, weak) UICollectionView *collectionView;

// 记录cell的代理
@property (nonatomic, weak) id cellDelegate;


// 所有的数据源
@property (nonatomic, strong) NSMutableArray<NSMutableArray*>* allContents;
// cell 的配置信息
@property (nonatomic, strong) NSMutableDictionary<NSString * ,JYNode *> *nodeCache;

// 是否使用了 CHTCollectionViewWaterfallLayout
@property (nonatomic, assign) BOOL isUseCHT;

@end

@implementation JYCollectionModel
#pragma mark -  注册cell tableView
- (void)registCellNodes:(NSArray<JYNode*>*)nodes byCollectionView:(UICollectionView*)collectionView  cellDelegate:(id)cellDelegate{
  _collectionView = collectionView;
  _cellDelegate = cellDelegate;
  [nodes enumerateObjectsUsingBlock:^(JYNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    Class cellClass = obj.groupCellNode.firstObject.cellClass;
      UINib *nib = obj.groupCellNode.firstObject.nib;
      if (nib) {
          [self.collectionView registerNib:nib forCellWithReuseIdentifier:[obj.groupCellNode.firstObject cellIdentifier]];
      }else {
          [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:[obj.groupCellNode.firstObject cellIdentifier]];
      }
    [self.nodeCache setObject:obj forKey:obj.identifier];
  }];
  self.isUseCHT = [self.collectionView.collectionViewLayout isKindOfClass:[CHTCollectionViewWaterfallLayout class]];
}

- (void)registCellNodes:(NSArray<JYNode*>*)nodes byCollectionView:(UICollectionView*)collectionView{
  [self registCellNodes:nodes byCollectionView:collectionView cellDelegate:nil];
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

#pragma mark - UICollectionView View 辅助计算
- (NSInteger)numberOfSections{
  if (self.isUseCHT && self.allContents.count == 0) {
    return 1;
  }
  return self.allContents.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
  if (self.isUseCHT && self.allContents.count == 0) {
    return 0;
  }
  return self.allContents[section].count;
}

- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [self sizeForRowAtIndexPath:indexPath config:nil];
}

- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UICollectionViewCell *aCell,JYNode* aNode))aConfig{
  return [self sizeForRowAtIndexPath:indexPath withWidth:0 config:aConfig];
}

- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width{
  return [self sizeForRowAtIndexPath:indexPath withWidth:width config:nil];
}

- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width config:(void (^)(UICollectionViewCell *aCell,JYNode* aNode))aConfig{
  if (self.isUseCHT) {
    CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout*)self.collectionView.collectionViewLayout;
    width = [layout itemWidthInSectionAtIndex:indexPath.section];
  }
  CGFloat height = 0;
  JYNode *node = [self getCellNodeAtIndexPath:indexPath];
  if (class_getClassMethod(node.cellNode.cellClass, @selector(heightForContent:withWidth:)) != nil){
    height = [node.cellNode.cellClass heightForContent:[node conversionModel] withWidth:width];
  }else if (class_getClassMethod(node.cellNode.cellClass, @selector(heightForContent:withWidth:cellNode:)) != nil){
      height = [node.cellNode.cellClass heightForContent:[node conversionModel] withWidth:width cellNode:node.cellNode];
  }else{
    NSString *key = [node heightCacheKey];
    height = [self.collectionView jy_heightForCellClass:node.cellNode.cellClass withIdentifier:node.cellNode.cellIdentifier width:width cacheBy:node.content key:key configuration:^(id cell) {
      [self configCell:cell forNode:node AtIndexPath:indexPath config:aConfig];
    }];
  }
  return CGSizeMake(width, height);
}

- (UICollectionViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [self cellForRowAtIndexPath:indexPath config:nil];
}
- (UICollectionViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UICollectionViewCell *aCell,JYNode *aNode))aConfig{
  JYNode *node = [self getCellNodeAtIndexPath:indexPath];
  UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[node.cellNode cellIdentifier] forIndexPath:indexPath];
  [self configCell:cell forNode:node AtIndexPath:indexPath config:aConfig];
  return cell;
}

- (void)configCell:(UICollectionViewCell *)cell forNode:(JYNode *)node AtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UICollectionViewCell *aCell,JYNode* aNode))aConfig{
  
  cell.jy_indexPath = indexPath;
  //  内容设置
  if ([cell respondsToSelector:@selector(setCellContent:)]) {
    [(id)cell setCellContent:[node conversionModel]];
  }
  
  if ([cell respondsToSelector:@selector(setCellDelegate:)]) {
    [(id)cell setCellDelegate:self.cellDelegate];
  }
  if (aConfig) {
    aConfig(cell,node);
  }
}

- (void)reomveObjectAtIndexPath:(NSIndexPath *)aIndexPath{
  if (self.allContents.count > aIndexPath.section) {
    NSMutableArray* arrayM = self.allContents[aIndexPath.section];
    if (arrayM.count > aIndexPath.row) {
      [arrayM removeObjectAtIndex:aIndexPath.row];
    }
  }
}

- (JYNode *)getCellNodeAtIndexPath:(NSIndexPath *)indexPath{
  NSArray *contents = [self contentsAtInSection:indexPath.section];
  if (contents.count <= 0) {
    return nil;
  }
  id content = contents[indexPath.row];
  JYNode *node = self.nodeCache[[JYNode identifierForContent:content]];
    NSAssert(node != nil, @"node不能为空请检查");
  [node recordCurrentIndex:0 content:content];
  return node;
}

#pragma mark - 懒加载
- (NSMutableDictionary<NSString *,JYNode *> *)nodeCache{
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
