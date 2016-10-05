//
//  JYTableModel.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYNode.h"

@class JYNode;

@interface JYTableModel : NSObject

// 所有的数据源
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray*>* allContents;

#pragma mark -  注册cell tableView
- (void)registCellNodes:(NSArray<JYNode*>*)nodes byTableView:(UITableView*)tableView;

#pragma mark - 辅助设置 需要先执行 registCellNodes
// 对cellNode间距的简单配置
- (void)configCellEdgeInsets:(UIEdgeInsets)edgeInsets marginColor:(UIColor *)marginColor;

#pragma mark - 数据操作
- (void)setContents:(NSArray *)aContents;
- (void)addContents:(NSArray *)aContents;

- (void)setContents:(NSArray *)aContents atSection:(NSInteger)aSection;
- (void)addContents:(NSArray *)aContents atSection:(NSInteger)aSection;

#pragma mark - Table View 辅助计算
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath config:(void (^)(UITableViewCell *aCell,id aContent))aConfig;


- (void)reomveObjectAtIndexPath:(NSIndexPath *)aIndexPath;
- (id)getObjectAtIndexPath:(NSIndexPath *)aIndexPath;
- (JYNode *)getCellNodeAtIndexPath:(NSIndexPath *)indexPath;

@end
