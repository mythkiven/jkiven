//
//  UIButton+Extension.m
//  CreditPlatform
//
//  Created by yj on 2016/11/10.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "UIButton+LMZXExtension.h"

#import "UIImage+LMZXTint.h"

#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]




@implementation UIButton (LMZXExtension)

+ (UIButton *)greeButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.layer.cornerRadius = 2;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundImage:[UIImage resizedImageWithColor:LM_RGB(57, 179, 27)] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage resizedImageWithColor:LM_RGB(30, 150, 0)] forState:(UIControlStateHighlighted)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return btn;
}

@end
