//
//  YJTypeMenuButton.m
//  下拉菜单
//
//  Created by yj on 16/9/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTypeMenuButton.h"
#define kImageW 20
#define kMaragin 5

@interface YJTypeMenuButton ()
{
    UIView *_line;
}
@property (nonatomic, weak) UIFont *titleFont;


@end
@implementation YJTypeMenuButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        [self setImage:[UIImage imageNamed:@"selected"] forState:(UIControlStateSelected)];
        
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self setTitleColor:RGB_blueText forState:(UIControlStateSelected)];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.titleFont = [UIFont systemFontOfSize:15];
        self.titleLabel.font = self.titleFont;
        self.imageView.contentMode = UIViewContentModeCenter;
        
        UIView *line = [self line];
        _line = line;
        [self addSubview:line];
        
        
        
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    
    CGFloat titleX = kImageW + kMaragin;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - titleX;

    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageY = 0;
    CGFloat imageW = kImageW;

    CGFloat imageX = 0;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _line.frame = CGRectMake(kMaragin+kImageW,  self.frame.size.height - .5, self.frame.size.width-kMaragin-kImageW, .5);
}

- (UIView *)line {
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB_grayLine;
    [self addSubview:line];
    
    return line;
}

@end
