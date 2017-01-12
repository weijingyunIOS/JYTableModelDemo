//
//  StyleCellModel.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "StyleCellModel.h"
#import "StyleCell1.h"
#import "StyleCell2.h"
#import "StyleCell3.h"
#import "StyleCell1Model.h"
#import "StyleCell2Model.h"
#import "StyleCell3Model.h"

@implementation StyleCellModel

// 返回对应HeaderCell数据模型
- (StyleCell1Model *)conversionModelForGroupHeaderCellNode:(JYCellNode *)aCellNode {
    return self.cell1Model;
}

// 返回中间 对应 数据模型 数组
- (NSArray<StyleCell2Model *> *)conversionModelForGroupCellNode:(JYCellNode *)aCellNode {
    return self.cell2ModelArray;
}

// 返回对应FooterCell数据模型
- (StyleCell3Model *)conversionModelForGroupFooterCellNode:(JYCellNode *)aCellNode {
    return self.cell3Model;
}

@end
