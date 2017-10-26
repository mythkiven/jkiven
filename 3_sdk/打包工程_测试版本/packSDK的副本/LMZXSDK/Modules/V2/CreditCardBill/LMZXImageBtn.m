//
//  LMZXImageBtn.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/24.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXImageBtn.h"

@implementation LMZXImageBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = (contentRect.size.width-150) * .5;
    CGFloat imageY = (contentRect.size.height-30) * .5;
    return CGRectMake(imageX, imageY, 150, 30);
    
}
@end
