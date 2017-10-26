//
//  UIBarButtonItem+Extension.m
//  inZhua
//
//  Created by yj on 16/5/26.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

#define kBarButtonItemFont [UIFont systemFontOfSize:13.0]



@implementation UIBarButtonItem (Extension)


+ (instancetype)barButtonItemWithIcon:(NSString *)icon title:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:(UIControlStateNormal)];
    
    UIImage *image = [UIImage imageNamed:icon];
    [btn setImage:image forState:(UIControlStateNormal)];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGFloat width = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.width + image.size.width;
//    btn.backgroundColor = [UIColor redColor];
    
    btn.bounds = CGRectMake(0, 0, width, 44.0);
    
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
    
    
//    CGSize temp = [@"末次缴存年月" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
//    
//    MYLog(@"末次缴存年月:%@",NSStringFromCGSize(temp));// 末次缴存年月:{90, 17.900390625}
    
    
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
    
    UIImage *image = [UIImage imageNamed:@"arrow_back"];
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

/**
 *  登录页面的返回按钮
 */
+ (instancetype)loginBackBarButtonItemtarget:(id)target action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateHighlighted)];
    
    UIImage *image = [UIImage imageNamed:@"login_icon_arrow_left"];
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
+ (instancetype)backBarButtonItem{
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    
    UIImage *image = [UIImage imageNamed:@"login_icon_arrow_left"];
    [btn setImage:image forState:(UIControlStateNormal)];
    [btn setImage:image forState:(UIControlStateHighlighted)];
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGFloat width = [@"返回" boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.width + image.size.width;
    
    btn.bounds = CGRectMake(0, 0, width + 5, 44.0);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
    
}

@end
