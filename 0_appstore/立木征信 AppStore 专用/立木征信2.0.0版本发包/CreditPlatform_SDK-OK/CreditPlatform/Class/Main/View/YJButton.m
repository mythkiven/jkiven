//
//  YJButton.m
//  3.Lottery彩票
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YJButton.h"

#define kTitleHeight 14

@implementation YJButton


- (void)setHighlighted:(BOOL)highlighted { };
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self setTitleColor:RGB_navBar forState:(UIControlStateSelected)];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height - kTitleHeight-2;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = kTitleHeight;
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height - kTitleHeight;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}


@end
