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
static char kJYTopLayer;
static char kJYLeftLayer;
static char kJYBottomLayer;
static char kJYRightLayer;

@interface UITableViewCell ()

@property (nonatomic, strong) CALayer *topLayer; // 上边颜色
@property (nonatomic, strong) CALayer *leftLayer; // 上边颜色
@property (nonatomic, strong) CALayer *bottomLayer; // 上边颜色
@property (nonatomic, strong) CALayer *rightLayer; // 上边颜色


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

#pragma mark - 以下方法需要先设置 edgeInsets 才有效
// 颜色一至 该性能更好
- (void)configEdgeInsetsColor:(UIColor *)color{
    self.backgroundColor = color;
}

// 单独配色可为空
- (void)configTopColor:(UIColor *)topColor leftColor:(UIColor *)leftColor bottomColor:(UIColor *)bottomColor rightColor:(UIColor *)rightColor{
    
    if (leftColor != nil) {
        
        if (self.leftLayer == nil) {
            self.leftLayer = [[CALayer alloc] init];
            self.leftLayer.frame = CGRectMake(0, 0, self.edgeInsets.left, self.frame.size.height);
            [self.layer addSublayer:self.leftLayer];
        }
        self.leftLayer.backgroundColor = leftColor.CGColor;
    }
    
    if (rightColor != nil) {
        
        if (self.rightLayer == nil) {
            self.rightLayer = [[CALayer alloc] init];
            self.rightLayer.frame = CGRectMake(self.frame.size.width  - self.edgeInsets.right, 0, self.edgeInsets.right, self.frame.size.height);
            [self.layer addSublayer:self.rightLayer];
        }
        self.rightLayer.backgroundColor = rightColor.CGColor;
    }
    
    if (topColor != nil) {
        
        if (self.topLayer == nil) {
            self.topLayer = [[CALayer alloc] init];
            self.topLayer.frame = CGRectMake(self.edgeInsets.left, 0, self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right, self.edgeInsets.top);
            [self.layer addSublayer:self.topLayer];
        }
        self.topLayer.backgroundColor = topColor.CGColor;
    }
    
    if (bottomColor != nil) {
        
        if (self.bottomLayer == nil) {
            self.bottomLayer = [[CALayer alloc] init];
            self.bottomLayer.frame = CGRectMake(self.edgeInsets.left, self.frame.size.height - self.edgeInsets.bottom, self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right, self.edgeInsets.bottom);
            [self.layer addSublayer:self.bottomLayer];
        }
        self.bottomLayer.backgroundColor = bottomColor.CGColor;
    }
    
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

- (void)setTopLayer:(CALayer *)topLayer{
    objc_setAssociatedObject(self,&kJYTopLayer,topLayer,OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)topLayer{
    return objc_getAssociatedObject(self, &kJYTopLayer);
}

- (void)setLeftLayer:(CALayer *)leftLayer{
    objc_setAssociatedObject(self,&kJYLeftLayer,leftLayer,OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)leftLayer{
    return objc_getAssociatedObject(self, &kJYLeftLayer);
}

- (void)setBottomLayer:(CALayer *)bottomLayer{
    objc_setAssociatedObject(self,&kJYBottomLayer,bottomLayer,OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)bottomLayer{
    return objc_getAssociatedObject(self, &kJYBottomLayer);
}

- (void)setRightLayer:(CALayer *)rightLayer{
    objc_setAssociatedObject(self,&kJYRightLayer,rightLayer,OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)rightLayer{
    return objc_getAssociatedObject(self, &kJYRightLayer);
}

@end
