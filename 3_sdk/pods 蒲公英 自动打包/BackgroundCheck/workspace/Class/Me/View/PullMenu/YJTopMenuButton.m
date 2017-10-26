//
//  YJTopMenuButton.m
//  下拉菜单
//
//  Created by yj on 16/9/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTopMenuButton.h"
#define kImageW 10
#define kMaragin 5

@interface YJTopMenuButton ()
@property (nonatomic, weak) UIFont *titleFont;


@end

@implementation YJTopMenuButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"icon_menu_down"] forState:(UIControlStateNormal)];
        [self setImage:[UIImage imageNamed:@"icon_menu_up"] forState:(UIControlStateSelected)];
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.backgroundColor = [UIColor clearColor];
        
        self.titleFont = [UIFont systemFontOfSize:15];
        self.titleLabel.font = self.titleFont;
        self.imageView.contentMode = UIViewContentModeCenter;
        
        
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    NSDictionary *attr = @{NSFontAttributeName : self.titleFont};
    CGFloat titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attr context:nil].size.width;
    
    CGFloat titleX = (contentRect.size.width - titleW - kImageW - kMaragin) * .5;
    CGFloat titleY = 0;

    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageY = 0;
    CGFloat imageW = kImageW;
    
    NSDictionary *attr = @{NSFontAttributeName : self.titleFont};
    CGFloat titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attr context:nil].size.width;
    
    
    CGFloat imageX = (contentRect.size.width - titleW - kImageW - kMaragin) * .5 +titleW + kMaragin;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}
@end
