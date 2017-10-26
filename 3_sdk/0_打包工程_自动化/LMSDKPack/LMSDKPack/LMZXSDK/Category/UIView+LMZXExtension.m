//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+LMZXExtension.h"
#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@implementation UIView (LMZXExtension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(BOOL)hasView:(UIView*)view{
    for (UIView *v  in self.subviews) {
        if ([v isEqual:view] |[v isKindOfClass:[view class]]|v==view) {
            return YES;
        }
    }
    return NO;
}
-(BOOL)removeSubView:(id)view{
    if ([view isKindOfClass:[UIView class]]) {
        UIView *View = (UIView *)view;
        for (UIView *v  in self.subviews) {
            if ([v isEqual:View] |[v isKindOfClass:[View class]]|v==View) {
                [v removeSubView:self];
                return YES;
            }
        }
    }
    
    return NO;
}

+ (UIView *)separationLine {
    UIView *line = [UIView new];
    line.backgroundColor = LM_RGB(224, 224, 224);
    return line;
}


@end
