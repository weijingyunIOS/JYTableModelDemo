//
//  UITableViewCell+JYCellMargin.m
//  Demo
//
//  Created by weijingyun on 16/10/2.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "UITableViewCell+JYCellMargin.h"
#import <Masonry.h>

static char kJYEdgeInsets;
@interface UITableViewCell ()


@end

@implementation UITableViewCell (JYCellMargin)

//+ (void)load{
//    JY_swizzling_exchangeMethod([self class], @selector(setFrame:), @selector(JY_Swizzling_setFrame:));
//}
//
//- (void)JY_Swizzling_setFrame:(CGRect)frame{
//
//    frame.origin.y += self.edgeInsets.top;
//    frame.size.height -= (self.edgeInsets.top + self.edgeInsets.bottom);
//    
//    frame.origin.x += self.edgeInsets.left;
//    frame.size.width -= (self.edgeInsets.left + self.edgeInsets.right);
//    [self JY_Swizzling_setFrame:frame];
//}

- (void)addMasonry{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).mas_offset(self.edgeInsets);
    }];
}

#pragma mark - 属性方法实现
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
     objc_setAssociatedObject(self,&kJYEdgeInsets,[NSValue valueWithUIEdgeInsets:edgeInsets],OBJC_ASSOCIATION_RETAIN);
    [self addMasonry];
}

- (UIEdgeInsets)edgeInsets{
    NSValue *value = objc_getAssociatedObject(self, &kJYEdgeInsets);
    return [value UIEdgeInsetsValue];
}

@end
