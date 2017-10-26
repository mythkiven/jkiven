//
//  UIColor+HEX.h
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)
/**
 *  根据十六进制数转rgb颜色
 *
 *  @param color 十六进制字符
 *
 */
+ (UIColor *) colorWithHexString: (NSString *)color;
    
    
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

@end
