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
- (StyleCell1Model *)conversionModelForGroupHeaderCellNode:(JYCellNode *)aCellNode;
// 返回中间 对应 数据模型 数组
- (NSArray<StyleCell2Model *> *)conversionModelForGroupCellNode:(JYCellNode *)aCellNode;
// 返回对应FooterCell数据模型
- (StyleCell3Model *)conversionModelForGroupFooterCellNode:(JYCellNode *)aCellNode;

@end
