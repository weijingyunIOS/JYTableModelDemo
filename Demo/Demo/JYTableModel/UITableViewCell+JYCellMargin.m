//
//  UITableViewCell+JYCellMargin.m
//  Demo
//
//  Created by weijingyun on 16/10/2.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "UITableViewCell+JYCellMargin.h"
#import <objc/runtime.h>

static char kJYEdgeInsets;
static char kJYTopLayer;
static char kJYLeftLayer;
static char kJYBottomLayer;
static char kJYRightLayer;
static char kJYLineLayer;
static char kJYViewConstraints;

@interface UITableViewCell ()

@property (nonatomic, strong) CALayer *topLayer; // 上边颜色
@property (nonatomic, strong) CALayer *leftLayer; // 左边颜色
@property (nonatomic, strong) CALayer *bottomLayer; // 下边颜色
@property (nonatomic, strong) CALayer *rightLayer; // 右边颜色

@property (nonatomic, strong) CALayer *lineLayer; // 分割线

// 四边约束 上左下右
@property (nonatomic, strong) NSArray<NSLayoutConstraint *> *viewConstraints;

@end

@implementation UITableViewCell (JYCellMargin)

// iOS7.0 可通过交换方法设置间距，不过也存在一定问题，就别适配7.0了
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
    
    if (self.viewConstraints == nil) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:self.edgeInsets.top];
        
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.edgeInsets.left];
        
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.edgeInsets.bottom];
        
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-self.edgeInsets.right];
        self.viewConstraints = @[top,left,bottom,right];
         [self addConstraints:@[top,left,bottom,right]];
        return;
    }
    self.viewConstraints[0].constant = self.edgeInsets.top;
    self.viewConstraints[1].constant = self.edgeInsets.left;
    self.viewConstraints[2].constant = - self.edgeInsets.bottom;
    self.viewConstraints[3].constant = - self.edgeInsets.right;
}

#pragma mark - 以下方法需要先设置 edgeInsets 才有效
// 颜色一至 该性能更好
- (void)configEdgeInsetsColor:(UIColor *)color{
    self.backgroundColor = color;
}

// 单独配色可为空
- (void)configTopColor:(UIColor *)topColor leftColor:(UIColor *)leftColor bottomColor:(UIColor *)bottomColor rightColor:(UIColor *)rightColor{
    
    if (leftColor != nil) {
        self.leftLayer.frame = CGRectMake(0, 0, self.edgeInsets.left, self.frame.size.height);
        self.leftLayer.backgroundColor = leftColor.CGColor;
    }
    
    if (rightColor != nil) {
        self.rightLayer.frame = CGRectMake(self.frame.size.width  - self.edgeInsets.right, 0, self.edgeInsets.right, self.frame.size.height);
        self.rightLayer.backgroundColor = rightColor.CGColor;
    }
    
    if (topColor != nil) {
        self.topLayer.frame = CGRectMake(self.edgeInsets.left, 0, self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right, self.edgeInsets.top);
        self.topLayer.backgroundColor = topColor.CGColor;
    }
    
    if (bottomColor != nil) {
        
        self.bottomLayer.frame = CGRectMake(self.edgeInsets.left, self.frame.size.height - self.edgeInsets.bottom, self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right, self.edgeInsets.bottom);
        self.bottomLayer.backgroundColor = bottomColor.CGColor;
    }
}

// 设置分割线
- (void)configSeparatorColor:(UIColor *)lineColor hidden:(BOOL)hidden{
    self.lineLayer.backgroundColor = lineColor.CGColor;
    self.lineLayer.hidden = hidden;
    self.lineLayer.frame = CGRectMake(0, self.frame.size.height - self.edgeInsets.bottom, self.frame.size.width, 0.5);
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
    if (objc_getAssociatedObject(self, &kJYTopLayer) == nil) {
        CALayer *layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
        [self setTopLayer:layer];
    }
    return objc_getAssociatedObject(self, &kJYTopLayer);
}

- (void)setLeftLayer:(CALayer *)leftLayer{
    objc_setAssociatedObject(self,&kJYLeftLayer,leftLayer,OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)leftLayer{
    if (objc_getAssociatedObject(self, &kJYLeftLayer) == nil) {
        CALayer *layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
        [self setLeftLayer:layer];
    }
    return objc_getAssociatedObject(self, &kJYLeftLayer);
}

- (void)setBottomLayer:(CALayer *)bottomLayer{
    objc_setAssociatedObject(self,&kJYBottomLayer,bottomLayer,OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)bottomLayer{
    if (objc_getAssociatedObject(self, &kJYBottomLayer) == nil) {
        CALayer *layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
        [self setBottomLayer:layer];
    }
    return objc_getAssociatedObject(self, &kJYBottomLayer);
}

- (void)setRightLayer:(CALayer *)rightLayer{
    objc_setAssociatedObject(self,&kJYRightLayer,rightLayer,OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)rightLayer{
    if (objc_getAssociatedObject(self, &kJYRightLayer) == nil) {
        CALayer *layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
        [self setRightLayer:layer];
    }
    return objc_getAssociatedObject(self, &kJYRightLayer);
}

- (void)setLineLayer:(CALayer *)lineLayer{
    objc_setAssociatedObject(self,&kJYLineLayer,lineLayer,OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)lineLayer{
    if (objc_getAssociatedObject(self, &kJYLineLayer) == nil) {
        CALayer *layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
        [self setLineLayer:layer];
    }
    return objc_getAssociatedObject(self, &kJYLineLayer);
}

- (void)setViewConstraints:(NSArray<NSLayoutConstraint *> *)viewConstraints{
    objc_setAssociatedObject(self,&kJYViewConstraints,viewConstraints,OBJC_ASSOCIATION_RETAIN);
}

- (NSArray<NSLayoutConstraint *> *)viewConstraints{
    return objc_getAssociatedObject(self, &kJYViewConstraints);
}

@end
