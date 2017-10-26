//
//  UIBarButtonItem+Extension.m
//  inZhua
//
//  Created by yj on 16/5/26.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "UIBarButtonItem+LMZXExtension.h"
#import "UIImage+LMZXTint.h"
#import "LMZXSDK.h"
#define lmzxkBarButtonItemFont [UIFont systemFontOfSize:13.0]



@implementation UIBarButtonItem (LMZXExtension)


+ (instancetype)barButtonItemWithIcon:(NSString *)icon title:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:(UIControlStateNormal)];
    
    UIImage *image = [UIImage imageFromBundle:@"lmzxResource" name:icon];
    // 这里需要加入主题颜色!
    if ([LMZXSDK shared].lmzxTitleColor) {
        image = [image imageWithTintColor:[LMZXSDK shared].lmzxTitleColor];
    }
    
    [btn setImage:image forState:(UIControlStateNormal)];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGFloat width = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.width + image.size.width;
    //    btn.backgroundColor = [UIColor redColor];
    
    btn.bounds = CGRectMake(0, 0, width, 44.0);
    
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    return item;
    
}

/**
 *  所有页面的返回按钮
 */
+ (instancetype)backBarButtonItemtarget:(id)target action:(SEL)action {
    
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];

    UIImage *image = [UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_back"];
    // 这里需要加入主题颜色!
    if ([LMZXSDK shared].lmzxTitleColor) {
        image = [image imageWithTintColor:[LMZXSDK shared].lmzxTitleColor];
        [btn setTitleColor:[LMZXSDK shared].lmzxTitleColor forState:UIControlStateNormal];
         [btn setTitleColor:[LMZXSDK shared].lmzxTitleColor forState:UIControlStateHighlighted];
    }
    [btn setImage:image forState:(UIControlStateNormal)];
    [btn setImage:image forState:(UIControlStateHighlighted)];
    
    
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGFloat width = [@"返回" boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.width + image.size.width;
    //    btn.backgroundColor = [UIColor redColor];
    
    btn.bounds = CGRectMake(0, 0, width + 5, 44.0);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
    
}

@end
