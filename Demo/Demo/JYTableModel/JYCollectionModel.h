//
//  JYCollectionModel.h
//  MeiShuBaoPro
//
//  Created by weijingyun on 16/10/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYNode.h"

@interface JYCollectionModel : NSObject

// 所有的数据源
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray*>* allContents;

#pragma mark -  注册cell tableView
- (void)registCellNodes:(NSArray<JYNode*>*)nodes byCollectionView:(UICollectionView*)collectionView  cellDelegate:(id)cellDelegate;

- (void)registCellNodes:(NSArray<JYNode*>*)nodes byCollectionView:(UICollectionView*)collectionView;

#pragma mark - 数据操作
- (void)setContents:(NSArray *)aContents;
- (void)addContents:(NSArray *)aContents;

- (void)setContents:(NSArray *)aContents atSection:(NSInteger)aSection;
- (void)addContents:(NSArray *)aContents atSection:(NSInteger)aSection;

- (BOOL)isEmpty;

#pragma mark - UICollectionView View 辅助计算
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UICollectionViewCell *aCell,JYNode* aNode))aConfig;
- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width;
- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width config:(void (^)(UICollectionViewCell *aCell,JYNode* aNode))aConfig;

// 如实现- (void)setCellContent:(id)aCellContent; CellDelegate 会走该方法
- (UICollectionViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UICollectionViewCell *aCell,JYNode* aNode))aConfig;


- (void)reomveObjectAtIndexPath:(NSIndexPath *)aIndexPath;
- (JYNode *)getCellNodeAtIndexPath:(NSIndexPath *)indexPath;

@end
