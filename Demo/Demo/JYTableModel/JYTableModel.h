//
//  JYTableModel.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYCellNode.h"

@class JYCellNode;

@interface JYTableModel : NSObject

// 所有的数据源
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray*>* allContents;

#pragma mark -  注册cell tableView
- (void)registCellNodes:(NSArray<JYCellNode*>*)nodes byTableView:(UITableView*)tableView;

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


@end
