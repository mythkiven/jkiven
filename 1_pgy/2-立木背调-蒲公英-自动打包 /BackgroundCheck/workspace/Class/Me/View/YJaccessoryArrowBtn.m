//
//  YJaccessoryArrowBtn.m
//  CreditPlatform
//
//  Created by yj on 16/8/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJaccessoryArrowBtn.h"
#define kArrowIconWidth 15

@implementation YJaccessoryArrowBtn



- (void)setAccessoryArrowType:(YJaccessoryArrowBtnType)accessoryArrowType {
    _accessoryArrowType = accessoryArrowType;
    
    if (_accessoryArrowType == YJaccessoryArrowBtnTypeNone) {
        [self setAccessoryIcon:nil];
        
        
    } else if (_accessoryArrowType == YJaccessoryArrowBtnTypeArrow) {
        [self setAccessoryIcon:@"arrow_right"];
        
    }
}



- (void)setAccessoryIcon:(NSString *)arrowIcon {
    if (arrowIcon) {
        [self setImage:[[UIImage imageNamed:arrowIcon] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateDisabled)];
        
    }else{
        [self setImage:[[UIImage imageNamed:@""] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateDisabled)];
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self setAccessoryIcon:@"arrow_right"];

        
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - kArrowIconWidth-10;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = contentRect.size.width - kArrowIconWidth;
    CGFloat imageY = 0;
    CGFloat imageW = kArrowIconWidth;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

@end
