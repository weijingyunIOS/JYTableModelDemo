//
//  JYTableModel.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCell+JYCellMargin.h"
#import "UITableView+JYTableLayoutCell.h"
#import "JYNode.h"

@interface JYTableModel : NSObject

// 所有的数据源
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray*>* allContents;

#pragma mark -  注册cell tableView

- (void)registCellNodes:(NSArray<JYNode*>*)nodes byTableView:(UITableView*)tableView cellDelegate:(id)cellDelegate;
- (void)registCellNodes:(NSArray<JYNode*>*)nodes byTableView:(UITableView*)tableView;

#pragma mark - 辅助设置 需要先执行 registCellNodes
// 对cellNode间距的简单配置
- (void)configCellEdgeInsets:(UIEdgeInsets)edgeInsets marginColor:(UIColor *)marginColor;

// 添加分割线，不调用则没有分割线, 是否隐藏分割线在每组最后一个cell
- (void)configSeparatorColor:(UIColor *)lineColor hiddenLast:(BOOL)hidden;

#pragma mark - 数据操作
- (void)setContents:(NSArray *)aContents;
- (void)addContents:(NSArray *)aContents;

- (void)setContents:(NSArray *)aContents atSection:(NSInteger)aSection;
- (void)addContents:(NSArray *)aContents atSection:(NSInteger)aSection;

- (BOOL)isEmpty;

#pragma mark - Table View 辅助计算
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UITableViewCell *aCell,JYNode* aNode))aConfig;// 自动计算高度可能要

// 如实现- (void)setCellContent:(id)aCellContent; 会走该方法
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UITableViewCell *aCell,JYNode* aNode))aConfig;


- (void)reomveObjectAtIndexPath:(NSIndexPath *)aIndexPath;
- (JYNode *)getCellNodeAtIndexPath:(NSIndexPath *)indexPath;

@end
