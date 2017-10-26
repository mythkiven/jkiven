//
//  YJBarButton.m
//  3.Lottery彩票
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YJBarButton.h"

@interface YJBarButton ()

@property (nonatomic, weak) UIFont *titleFont;

@end

@implementation YJBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titleFont = [UIFont systemFontOfSize:18];
        self.titleLabel.font = self.titleFont;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}




- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    CGFloat titleX = 0;
    CGFloat titleY = 0;
    NSDictionary *attr = @{NSFontAttributeName : self.titleFont};
    CGFloat titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attr context:nil].size.width;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);

}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageY = 0;
    CGFloat imageW = 20;
    CGFloat imageX = contentRect.size.width - 20;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}



@end
