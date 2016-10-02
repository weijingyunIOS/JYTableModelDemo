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

// 模型转化，对应相应Cell 要转换成对应模型
- (id)conversionModelForCellClass:(Class)aCellClass{
    
    id model = nil;
    if (aCellClass == [StyleCell1 class]) {
         model = [[StyleCell1Model alloc] init];
        ((StyleCell1Model *)model).cellTitle = self.cell1Title;
        ((StyleCell1Model *)model).cellSubTitle = self.cell1SubTitle;
        
    }else if (aCellClass == [StyleCell2 class]) {
         model = [[StyleCell2Model alloc] init];
        ((StyleCell2Model *)model).cellTitle = self.cell2Title;
        ((StyleCell2Model *)model).cellSubTitle = self.cell2SubTitle;
        
    }else if (aCellClass == [StyleCell3 class]) {
         model = [[StyleCell3Model alloc] init];
        ((StyleCell3Model *)model).cellTitle = self.cell3Title;
        ((StyleCell3Model *)model).cellSubTitle = self.cell3SubTitle;
        
    }
    return model;
}

@end
