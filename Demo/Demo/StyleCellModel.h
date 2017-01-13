//
//  StyleCellModel.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYNodeProtocol.h"
#import "StyleCell1Model.h"
#import "StyleCell2Model.h"
#import "StyleCell3Model.h"

@interface StyleCellModel : NSObject<JYGroupContentProtocol>

@property (nonatomic, strong) StyleCell1Model *cell1Model;
@property (nonatomic, strong) NSArray<StyleCell2Model *> *cell2ModelArray;
@property (nonatomic, strong) StyleCell3Model *cell3Model;


// 返回对应HeaderCell数据模型
- (id)conversionModelForGroupHeaderCellNode:(JYCellNode *)aCellNode;

// 中间 GroupCell 数量
- (NSInteger)getConversionModelCountForGroupCellNode:(JYCellNode *)aCellNode;
// 返回中间 对应 数据模型  跟 getConversionModelCountForGroupCellNode 对应
- (id)conversionModelForGroupCellNode:(JYCellNode *)aCellNode index:(NSInteger)aIndex;

// 返回对应FooterCell数据模型
- (id)conversionModelForGroupFooterCellNode:(JYCellNode *)aCellNode;

@end
