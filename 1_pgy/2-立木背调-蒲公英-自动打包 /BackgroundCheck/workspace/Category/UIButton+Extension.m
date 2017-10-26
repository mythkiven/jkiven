//
//  UIButton+Extension.m
//  CreditPlatform
//
//  Created by yj on 2016/11/10.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (UIButton *)greeButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.layer.cornerRadius = 2;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [btn setTitleColor:RGB_white forState:UIControlStateNormal];
    [btn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return btn;
}

@end
