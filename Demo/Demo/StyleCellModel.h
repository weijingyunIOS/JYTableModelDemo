//
//  StyleCellModel.h
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYNodeProtocol.h"

@interface StyleCellModel : NSObject<JYContentNodeProtocol>

@property (nonatomic, copy) NSString *cell1Title;
@property (nonatomic, copy) NSString *cell1SubTitle;

@property (nonatomic, copy) NSString *cell2Title;
@property (nonatomic, copy) NSString *cell2SubTitle;

@property (nonatomic, copy) NSString *cell3Title;
@property (nonatomic, copy) NSString *cell3SubTitle;

@end
